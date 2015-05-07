class Post < ActiveRecord::Base
  belongs_to :user

  validates :body, length: { minimum: 250 }

  def get_frist_sentence
  	first_sentence_end_index = body.include?(".") ? body.index('.') : 139

  	body[0..first_sentence_end_index]
  end
end
