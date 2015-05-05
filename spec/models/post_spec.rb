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

  	context "proper sentence" do
  		it "return a proper sentence" do
  			post.body = Faker::Lorem.sentence(14)

  			sentence = post.get_frist_sentence

  			expect(sentence).to eq(post.body)
  		end
  	end
  end
end
