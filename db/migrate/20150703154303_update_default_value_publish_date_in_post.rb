class UpdateDefaultValuePublishDateInPost < ActiveRecord::Migration
  def change
		execute "ALTER TABLE posts ALTER COLUMN publish_date SET DEFAULT CURRENT_TIMESTAMP" 
  end
end
