require 'rails_helper'
require 'capybara/rspec'

RSpec.feature "Users", type: :feature do
  describe "#create" do
    context "a user" do
    	it "responds with 200" do
    		visit root_url
        find(".main-header-navigation-wrapper-non-mobile-menu").click_link "Sign Up"

    		within "#new_user" do
    			user_new_password = "Pass3word:"

    			fill_in "First Name", with: Faker::Name.first_name
    			fill_in "Last Name", with: Faker::Name.last_name
    			fill_in "Username", with: Faker::Internet.user_name
    			fill_in "Email", with: Faker::Internet.free_email
    			fill_in "Password", with: user_new_password
    			fill_in "Password Confirmation", with: user_new_password
    		end

    		click_button "Sign Up"
        expect(page.status_code).to be(200)  
    	end
    end
  end

  describe "#edit" do
    let(:user) { create(:user) }
    
    context "when not login" do
      it "responds with login link" do
        visit "/users/#{user.id}/edit"

        expect(current_path).to eq("/login")
      end
    end

    context "a user" do
      it "responds with 200" do 
        login_user_post(user.username, "Pass3word:")
        new_username = Faker::Internet.user_name

        visit root_url
        find(".main-header-navigation-wrapper-non-mobile-menu").click_link "Edit"

        within ".materialize-row-form" do
          fill_in "Username", with: new_username
        end

        click_button "Update"
        expect(page.status_code).to be(200)

        expect(User.find(user.id).username).to eq new_username
      end
    end
  end
end
