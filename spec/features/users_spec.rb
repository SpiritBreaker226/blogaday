require 'rails_helper'
require 'capybara/rspec'

RSpec.feature "Users", type: :feature do
  describe "sign up process" do
  	it "should create a user" do
  		visit "/signup"
  		
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
  		expect(page).to have_content "Your account has been created"
  	end
  end
end
