class AddPublishDateToPost < ActiveRecord::Migration
  def change
    add_column :posts, :publish_date, :timestamp
  end
end
