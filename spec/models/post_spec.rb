require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { create(:post) } 

  describe "#get_frist_sentence" do
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

    context "with markdown body and proper sentence" do
      let(:post_with_markdown) { create(:post, body: "### #{Faker::Hacker.say_something_smart}\n*#{Faker::Lorem.sentences(14)}*") }
      subject(:sentence_with_markdown) { post_with_markdown.get_frist_sentence } 

      it "return string with no markdown tags" do
        expect(sentence_with_markdown.include?("###")).to be(false)
      end

      it "return string with no HTML tags" do
        expect(sentence_with_markdown.include?("<h3>")).to be(false)
      end

      it "return a plain text version with a sentence" do
        expect(sentence_with_markdown.index('.')).to eq((sentence_with_markdown.length - 1))
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

      it "return plain text version" do
        expect(post_with_markdown.render_markdown_post_to_html(plaintext_instead: true).include?("<em>")).to be(false)
      end
    end

    context "post without markdown body" do
      it "return string with p tag around it" do
        expect(post.render_markdown_post_to_html).to eq("<p>#{post.body}</p>\n")
      end
    end
  end

  describe "#display_and_order_by_publish_date" do
    let!(:post) { create(:user_with_posts, num_posts: 25) }

    context "when publish date is nil" do
      it "return nil" do
        post_with_publish_date_nil = Post.display_and_order_by_publish_date.find { |post| post.publish_date == nil }

        expect(post_with_publish_date_nil).to be(nil)
      end
    end

    context "when publish date is in the now" do
      it "return greater then 0" do
        expect(Post.display_and_order_by_publish_date.count).to be > 0
      end
    end

    context "when publish date is only for one user" do
      let!(:post_different_user) { create(:post, publish_date: 3.days.ago) }

      it "return 1" do
        last_user_be_created = Post.last.user

        expect(Post.display_and_order_by_publish_date.where(user: last_user_be_created).count).to be(1)
      end
    end

    context "order by publish_date from latest to oldest" do
      it "return first post publish date be greater then last post publish date" do
        posts = Post.display_and_order_by_publish_date

        expect(posts.first.publish_date).to be > posts.last.publish_date
      end

      it "return first post not be 1 hours from now" do
        publish_date = 1.hours.from_now
        create(:post, publish_date: 1.hours.from_now)

        expect(Post.display_and_order_by_publish_date.first.publish_date.hour).not_to be publish_date
      end
    end
  end
end
