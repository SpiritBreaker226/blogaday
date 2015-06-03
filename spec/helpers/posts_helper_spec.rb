require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the PostsHelper. For example:
#
# describe PostsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe PostsHelper, type: :helper do
	describe "#display_post_summary" do
		context "use summary text" do
			let(:post) { create(:post) }

			it "return a sentence for the summary" do
				expect(helper.display_summary(post)).to eq(post.summary)
			end
		end

		context "no summary text use first sentence" do
			let(:post_no_summary) { create(:post, summary: "") }	

			it "return a sentence with get_frist_sentence" do
				post_no_summary.body = Faker::Lorem.sentence(14)

				expect(helper.display_summary(post_no_summary)).to eq(post_no_summary.get_frist_sentence)
			end

			it "return 140 characters" do
  			expect(helper.display_summary(post_no_summary).length).to eq(140)
  		end
		end
	end
end
