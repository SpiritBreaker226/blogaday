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

  describe "sign in process" do
  	let!(:user) { create(:user) }

  	it "should sign me in" do
  		visit "/signin"

  		within "#signin" do
  			fill_in "Username", with: user.username
  			fill_in "Password", with: "Pass3word:"
  		end

  		click_button "Sign In"
  		expect(page).to have_content "Sign in successful"
  	end
  end

  describe "sign out process" do
  	let!(:user) { create(:user) }

		it "should sign me out" do
			login_user_post(user.username, "Pass3word:")

			visit "/"
			click_link "Sign Out"
			expect(page).to have_content "Signed out"	
		end
	end

	describe "edit user process" do
		let(:user) { create(:user) }
		
		it "should not be on edit if not sign in" do
			visit "/users/#{user.id}/edit"

			expect(current_path).to eq("/signin")
		end

		context "should be able to change" do
			it "#username" do 
				login_user_post(user.username, "Pass3word:")
				new_username = Faker::Internet.user_name

				visit "/"
				click_link "Edit"
	  		within ".edit_user" do
	  			fill_in "Username", with: new_username
	  		end

	  		click_button "Update"
				expect(page).to have_content "Your account has been updated"

				expect(User.find(user.id).username).to eq new_username
			end
		end
	end
end
