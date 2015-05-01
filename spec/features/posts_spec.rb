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

  describe "#edit" do
  	let!(:user) { create(:user_with_posts) }

  	context "frist post" do
  		it "responds with 200" do
  			new_post_title = Faker::Hacker.say_something_smart
  			
  			login_user_post(user.username, "Pass3word:")

	  		visit edit_user_post_url(user, user.post.first)

	  		within ".edit_post" do
	  			fill_in "Title", with: new_post_title
	  		end

	  		click_button "Update Post"
	  		expect(page).to have_content "post has been updated"

	  		expect(Post.find(user.post.first.id).title).to eq new_post_title
  		end
  	end
  end
end
