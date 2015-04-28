require 'rails_helper'
require 'capybara/rspec'

RSpec.feature "Posts", type: :feature do
  describe "#create" do
  	let(:user) { create(:user) }

  	context "with one post" do
  		it "responds with 200" do
  			login_user_post(user.username, "Pass3word:")

	  		visit root_url
	      click_link "Create Post"

	  		within "#new_post" do
	  			fill_in "Title", with: Faker::Hacker.say_something_smart
	  			fill_in "Body", with: Faker::Lorem.paragraph((1..5).to_a.sample, true)
	  		end

	  		click_button "Create Post"
	  		expect(page).to have_content "post has been created"
	  	end
  	end
  end
end
