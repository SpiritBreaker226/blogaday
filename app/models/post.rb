class Post < ActiveRecord::Base
  belongs_to :user

  validates :body, length: { minimum: 250 }

  def get_frist_sentence
  	if body.include? "."
  		body
  	else
  		body[0..139]
  	end
  end
end
