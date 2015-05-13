require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "#get_frist_sentence" do
  	let(:post) { create(:post) } 

  	context "just with characters, no period" do
			subject(:sentence) { post.get_frist_sentence } 

  		it "return 140 characters" do
  			expect(sentence.length).to eq(140)
  		end

  		it "return 140 characters when over 140 characters" do
  			post.body = Faker::Lorem.characters(300)

  			expect(sentence.length).to eq(140)  			
  		end
  	end

  	context "proper sentence" do
  		it "return a sentence" do
  			post.body = Faker::Lorem.sentence(14)

  			expect(post.get_frist_sentence).to eq(post.body)
  		end

  		it "return a sentence when more then one" do
				post.body = Faker::Lorem.sentences(10)

				sentence = post.get_frist_sentence

  			expect(sentence.index('.')).to eq((sentence.length - 1))
  		end
  	end
  end
end
