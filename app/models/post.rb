class Post < ActiveRecord::Base
  belongs_to :user

  validates :body, length: { minimum: 250 }

  def get_frist_sentence
		"ssasdfasdfasdfasdfasdfasdfafasdfasdfasdfasdfasdfasdfadfasfasfasdfasfaadfasdfadsfadsfasdfadfadsafadfafdfdsffdsadfsadfsafdfdfdffffffffffffssss"
  end
end
