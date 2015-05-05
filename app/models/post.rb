class Post < ActiveRecord::Base
  belongs_to :user

  validates :body, length: { minimum: 250 }
end
