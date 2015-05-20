require 'rails_helper'
require 'capybara/rspec'

RSpec.feature "Users", type: :feature do
  describe "sign up process" do
  	it "should create a user" do
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

  describe "login process" do
  	let(:user) { create(:user) }

  	it "should login" do
  		visit root_url
      find(".main-header-navigation-wrapper-non-mobile-menu").click_link "Login"

  		within "#login" do
  			fill_in "Username", with: user.username
  			fill_in "Password", with: "Pass3word:"
  		end

  		click_button "Login"
      expect(page.status_code).to be(200)
  	end
  end

  describe "logout process" do
  	let(:user) { create(:user) }

		it "should logout" do
			login_user_post(user.username, "Pass3word:")

			visit root_url
			find(".main-header-navigation-wrapper-non-mobile-menu").click_link "Logout"
      expect(page.status_code).to be(200)
		end
	end

	describe "edit user process" do
		let(:user) { create(:user) }
		
		it "should not be on edit if not login" do
			visit "/users/#{user.id}/edit"

			expect(current_path).to eq("/login")
		end

		context "should be able to change" do
			it "#username" do 
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
