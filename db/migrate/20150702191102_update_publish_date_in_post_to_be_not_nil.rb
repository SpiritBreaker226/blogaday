class UpdatePublishDateInPostToBeNotNil < ActiveRecord::Migration
  def change
  	change_column :posts, :publish_date, :timestamp, :default => Time.now

  	posts_with_no_publish_date = Post.where(publish_date: nil)

  	posts_with_no_publish_date.each do |post|
  		post.publish_date = Time.now
  		post.save
  	end
  end
end
