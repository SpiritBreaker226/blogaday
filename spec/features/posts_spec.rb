require 'rails_helper'
require 'capybara/rspec'

RSpec.feature "Posts", type: :feature do
  subject(:click_submit) { click_button "Submit" }

  describe "#create" do
  	let(:user) { create(:user) }

    subject(:vist_create_post) do
      login_user_post(user.username, "Pass3word:")

      visit root_url
      find(".main-header-navigation-wrapper-non-mobile-menu").click_link "Create Post"
    end

  	context "with one post" do
      subject(:create_proper_post) {
        within "#new_post" do
          fill_in "Title", with: Faker::Hacker.say_something_smart
          fill_in "Body", with: Faker::Lorem.characters
        end

        click_submit
      }

  		it "responds with 200" do
        vist_create_post

        create_proper_post

	  		expect(page.status_code).to be(200)
	  	end

      context "with no title & body" do
        it "return back to create" do
          vist_create_post

          click_submit
          expect(page.current_path).to eq("/posts")
        end

        context "after fixes validation error" do
          it "responds with 200" do
            vist_create_post

            click_submit

            create_proper_post
            expect(page.status_code).to be(200)  
          end
        end
      end
  	end
  end

  describe "#edit" do
  	let!(:user) { create(:user_with_posts) }

  	context "frist post" do
  		it "responds with 200" do
  			new_post_title = Faker::Hacker.say_something_smart
  			
  			login_user_post(user.username, "Pass3word:")

	  		visit edit_post_url(user.posts.first)

	  		within ".materialize-row-form" do
	  			fill_in "Title", with: new_post_title
	  		end

	  		click_submit
	  		expect(page.status_code).to be(200)

	  		expect(Post.find(user.posts.first.id).title).to eq new_post_title
  		end
  	end
  end
end
