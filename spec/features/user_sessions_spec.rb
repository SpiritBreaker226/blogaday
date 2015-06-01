require 'rails_helper'
require 'capybara/rspec'

RSpec.feature "UserSessions", type: :feature do
  describe "#new" do
    context "already login" do
      it "responds with root_url" do
        user = create(:user)

        login_user_post(user.username, "Pass3word:")

        visit login_path
        expect(page.current_url).to eq(root_url)
      end
    end
  end

  describe "#create" do
  	let(:user) { create(:user) }
    
    subject(:visit_login) do
      visit root_url
      find(".main-header-navigation-wrapper-non-mobile-menu").click_link "Login"
    end

  	it "responds with 200" do 
  		visit_login
    
  		within "#login" do
  			fill_in "Username", with: user.username
  			fill_in "Password", with: "Pass3word:"
  		end

  		click_button "Login"
      expect(page.status_code).to be(200)
  	end

    context "login fail" do
      it "responds with login form" do
        visit_login

        click_button "Login"
        expect(page.current_path).to eq(user_sessions_path)
      end
    end
  end

  describe "#destroy" do
  	let(:user) { create(:user) }

		it "responds with 200" do 
			login_user_post(user.username, "Pass3word:")

			visit root_url
			find(".main-header-navigation-wrapper-non-mobile-menu").click_link "Logout"

      expect(page.status_code).to be(200)
		end
	end
end
