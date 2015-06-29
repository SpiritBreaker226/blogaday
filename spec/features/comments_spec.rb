require 'rails_helper'
require 'capybara/rspec'

RSpec.feature "Comments", type: :feature do
	let(:post_with_comments) { create(:post_with_comments) }
  subject(:click_submit) { click_button "Submit" }

  describe "#create" do
  	let(:post) { create(:post) }
    let(:user) { create(:user) }
    subject(:visit_post) { visit post_url(post) }

  	context "with post has no comments" do
  		it "responds with 200" do
        login_user_post(user.username, "Pass3word:")

        visit_post

        within "#new_comment" do
          fill_in "Body", with: Faker::Lorem.characters
        end

        click_submit

        expect(page.status_code).to be(200)
      end

      context "and no body" do
        it "return back to create" do
          login_user_post(user.username, "Pass3word:")

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

        visit edit_post_comment_url(Post.first, user.comments.first)
      end

      it "responds with 200" do
        login_and_visit_edit_page

        within ".materialize-row-form" do
          fill_in "Body", with: Faker::Lorem.characters
        end

        click_submit

        expect(page.status_code).to be(200) 
      end
    end
  end
end
