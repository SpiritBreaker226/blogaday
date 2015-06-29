require 'rails_helper'
require 'capybara/rspec'

RSpec.feature "Comments", type: :feature do
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
end
