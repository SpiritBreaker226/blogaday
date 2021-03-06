require 'rails_helper'
require 'capybara/rspec'

RSpec.feature "Users", type: :feature do
  describe "#create" do
    subject(:visit_sign_up) do
      visit root_url
      find(".main-header-navigation-wrapper-non-mobile-menu").click_link "Sign Up"
    end

    subject(:click_sign_up) { click_button "Sign Up" }

    context "a user" do
    	it "responds with 200" do
        visit_sign_up	

    		within "#new_user" do
    			user_new_password = "Pass3word:"

    			fill_in "First Name", with: Faker::Name.first_name
    			fill_in "Last Name", with: Faker::Name.last_name
    			fill_in "Username", with: Faker::Internet.user_name
    			fill_in "Email", with: Faker::Internet.free_email
    			fill_in "Password", with: user_new_password
    			fill_in "Password Confirmation", with: user_new_password
    		end

    		click_sign_up
        expect(page.status_code).to be(200)  
    	end

      context "invalid sign up form" do
        it "responds with sign up form" do
          visit_sign_up

          click_sign_up
          expect(page.current_path).to eq(users_path)
        end
      end
    end
  end

  describe "#edit" do
    let(:user) { create(:user) }
    
    context "when not login" do
      it "responds with login link" do
        visit edit_user_path(user)

        expect(current_path).to eq(login_path)
      end
    end

    context "a user" do
      subject(:click_update) { click_button "Update" }

      subject(:login_and_visit_edit_page) do
        login_user_post(user.username, "Pass3word:")

        visit root_url
        find(".main-header-navigation-wrapper-non-mobile-menu").click_link "Edit"
      end

      it "responds with 200" do 
        new_username = Faker::Internet.user_name

        login_and_visit_edit_page

        within ".materialize-row-form" do
          fill_in "Username", with: new_username
        end

        click_update
        expect(page.status_code).to be(200)

        expect(User.find(user.id).username).to eq new_username
      end

      context "invalid edit form" do
        it "responds with edit form" do
          login_and_visit_edit_page

          within ".materialize-row-form" do
            fill_in "Username", with: ""
          end

          click_update
          expect(page.current_path).to eq(user_path(user))
        end
      end
    end
  end

  describe "#show" do
    let(:user) { create(:user) }

    subject(:login_and_visit_show_page) do
      login_user_post(user.username, "Pass3word:")

      visit root_url
      find(".main-header-navigation-wrapper-non-mobile-menu").click_link "Profile"
    end

    context "have profile" do
      it "responds with 200" do
        login_and_visit_show_page

        expect(page.status_code).to be(200)
      end
    end

    context "display feeds" do 
      it "responds with JSON format" do
        login_and_visit_show_page

        click_link "JSON Feed"

        expect(page.current_url.include?(".json")).to be(true)
      end

      it "responds with RSS format" do
        login_and_visit_show_page

        click_link "RSS Feed"

        expect(page.current_url.include?(".atom")).to be(true)
      end
    end
  end
end
