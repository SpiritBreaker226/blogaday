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

          select(3.hours.from_now.strftime("%I %p"), from: :post_publish_date_4i)
          select(Time.now.strftime("%M"), from: :post_publish_date_5i)
        end

        click_submit
      }

  		it "responds with 200" do
        vist_create_post

        create_proper_post

	  		expect(page.status_code).to be(200)
	  	end

      it "responds with 200 with publish 3 hours from now" do
        vist_create_post

        create_proper_post

        latest_post = Post.last

        expect(page.status_code).to be(200)
        expect(latest_post.publish_date.strftime("%I:%M %p")).to eq(3.hours.from_now.strftime("%I:%M %p"))
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

    context "with one post and summary" do
      subject(:create_proper_post_with_summary) {
        within "#new_post" do
          fill_in "Title", with: Faker::Hacker.say_something_smart
          fill_in "Body", with: Faker::Lorem.characters
          fill_in "Summary", with: Faker::Lorem.sentence
        end

        click_submit
      }

      it "responds with 200" do
        vist_create_post

        create_proper_post_with_summary

        expect(page.status_code).to be(200)
      end

      context "with too many chartecters in summary" do
        it "return back to create" do
          vist_create_post

          within "#new_post" do
            fill_in "Title", with: Faker::Hacker.say_something_smart
            fill_in "Body", with: Faker::Lorem.characters
            fill_in "Summary", with: Faker::Lorem.characters(512)
          end

          click_submit
          expect(page.current_path).to eq("/posts")
        end
      end
    end
  end

  describe "#edit" do
  	let!(:user) { create(:user_with_posts) }

    context "first post" do
      subject(:login_and_visit_edit_page) do
        login_user_post(user.username, "Pass3word:")

        visit edit_post_url(user.posts.first)
      end

  		it "responds with 200" do
  			new_post_title = Faker::Hacker.say_something_smart
  			
        login_and_visit_edit_page

	  		within ".materialize-row-form" do
	  			fill_in "Title", with: new_post_title
	  		end

	  		click_submit
	  		expect(page.status_code).to be(200)

	  		expect(Post.find(user.posts.first.id).title).to eq new_post_title
  		end

      context "invalid edit form" do
        it "responds with edit form" do
          login_and_visit_edit_page

          within ".materialize-row-form" do
            fill_in "Title", with: ""
          end

          click_submit
          expect(page.current_path).to eq(post_path(user.posts.first))
        end
      end
  	end
  end

  describe "#destroy" do
    let!(:user) { create(:user_with_posts) }

    context "Removes second post" do
      it "responds with 200" do
        login_user_post(user.username, "Pass3word:")

        visit post_url(user.posts.second)

        click_on "Delete"
        expect(page.status_code).to be(200)
        expect(Post.where('user_id = ?', user).count).to be(2)
      end
    end
  end
end
