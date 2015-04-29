class AddDailyReminderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :daily_reminder, :time, default: Time.at(1426842000)
    add_column :users, :enable_daily_reminder, :boolean, default: true
  end
end
