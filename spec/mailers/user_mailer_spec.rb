require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
	let!(:user) { create(:user) }
	let(:mail) { UserMailer.reminder_to_blog_email(user) }

  describe "#reminder_to_blog" do
  	context "when email is sent" do
  		it "have to address" do 
  			expect(mail.to).to eql [user.email]
  		end

  		it "have to subject" do 
  			expect(mail.subject).to match "Time To Blog"
  		end

  		it "assign @new_post_url" do
  			expect(mail.body.encoded).to match("/#{user.id}/posts/new")
  		end
  	end
  end
end
