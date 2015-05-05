require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "#get_frist_sentence" do
  	let(:post) { create(:post) } 

  	context "just with characters, no period" do
  		it "return 140 charters" do
  			sentence = post.get_frist_sentence

  			expect(sentence.length).to eq(140)
  		end
  	end
  end
end
