require 'rails_helper'
require 'capybara/rspec'

RSpec.feature "Comments", type: :feature do
	let(:post_with_comments) { create(:post_with_comments) }
  subject(:click_submit) { click_button "Submit" }

  describe "#create" do
  	let(:post) { create(:post) }
    let(:user) { create(:user) }
    subject(:visit_post) do 
      login_user_post(user.username, "Pass3word:")
      
      visit post_url(post) 
    end

  	context "with post has no comments" do
  		it "responds with 200" do
        visit_post

        within "#new_comment" do
          fill_in "Body", with: Faker::Lorem.characters
        end

        click_submit

        expect(page.status_code).to be(200)
      end

      context "and no body" do
        it "return back to create" do
          visit_post

          click_submit

          expect(page.current_path).to eq("/posts/#{post.id}/comments")
        end
      end
  	end
  end
  
  describe "#edit" do
    context "second comment" do
      subject(:login_and_visit_edit_page) do
        post_with_comments

        user = Post.first.comments.second.user

        login_user_post(user.username, "Pass3word:")

        visit edit_post_comment_url(Post.first, Post.first.comments.second)
      end

      it "responds with 200" do
        login_and_visit_edit_page

        within ".materialize-row-form" do
          fill_in "Body", with: Faker::Lorem.characters
        end

        click_submit

        expect(page.status_code).to be(200) 
      end

      context "and no body" do
        it "responds with edit form" do
          login_and_visit_edit_page

          within ".materialize-row-form" do
            fill_in "Body", with: ""
          end

          click_submit

          expect(page.current_path).to eq(post_comment_path(Post.first, Post.first.comments.second))
        end
      end
    end
  end

  describe "#destroy" do
    context "Removes third comment" do
      it "responds with 200" do
        post_with_comments

        first_post = Post.first
        first_post_comment = first_post.comments.third
        number_of_comments_post = first_post.comments.count

        login_user_post(first_post_comment.user.username, "Pass3word:")

        visit post_url(first_post)

        find(".current_user_comment_controls_for_#{first_post_comment.id}").click_on "Delete"

        expect(page.status_code).to be(200)
        expect(Post.first.comments.count).to be((number_of_comments_post - 1))
      end
    end
  end
end
