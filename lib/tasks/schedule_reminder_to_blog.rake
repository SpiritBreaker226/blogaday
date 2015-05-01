namespace :schedule_reminder do
	desc "Send out reminders to users to blog"
	task to_blog: :environment do
		users = User.where("daily_reminder = ? AND enable_daily_reminder = ?", Time.now.at_beginning_of_hour, true)

		users.each do |user|
			UserMailer.reminder_to_blog_email(user).deliver_later
			puts "sent to #{user.email}"
		end
	end
end
