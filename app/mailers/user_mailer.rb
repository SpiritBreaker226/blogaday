class UserMailer < ApplicationMailer
	def reminder_to_blog_email(user)
		@user = user
		@new_post_url = new_user_post_url(@user)

		mail to: @user.email, subject: "Time To Blog"
	end
end
