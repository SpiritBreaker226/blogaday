require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the UsersHelper. For example:
#
# describe UsersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe UsersHelper, type: :helper do
  describe "#user_author_any_post?" do
  	context "user has no post" do
  		let(:user) { create(:user) }

  		it "return false" do
  			expect(helper.user_author_any_post?(user.posts)).to be(false)
  		end
  	end

  	context "user has post" do
  		let(:user) { create(:user_with_posts) }

  		it "return true" do
  			expect(helper.user_author_any_post?(user.posts)).to be(true)
  		end
  	end
  end
end
