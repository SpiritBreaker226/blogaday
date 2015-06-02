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

  describe "#render_markdown_post_to_html" do
    let(:post_with_markdown) { create(:post, body: "### #{Faker::Hacker.say_something_smart}\n*#{Faker::Lorem.sentences}* \n**#{Faker::Lorem.words(19)}**\n#{Faker::Internet.url}") } 

    context "post with markdown body" do
      it "return string includes <h3>" do
        expect(post_with_markdown.render_markdown_post_to_html.include?("<h3>")).to be(true)
      end

      it "return string includes link" do
        expect(post_with_markdown.render_markdown_post_to_html.include?("<a href=")).to be(true)
      end
    end
  end
end
