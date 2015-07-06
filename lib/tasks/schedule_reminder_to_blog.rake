namespace :schedule_reminder do
	desc "Send out reminders to users to blog"
	task to_blog: :environment do
		users = User.where(daily_reminder: Time.now.at_beginning_of_hour..Time.now.at_end_of_hour).where(enable_daily_reminder: true)

		users.each do |user|
			UserMailer.reminder_to_blog_email(user).deliver_later
			puts "sent to #{user.email}"
		end
	end
end
