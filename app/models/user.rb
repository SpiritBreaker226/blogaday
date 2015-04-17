class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :username, presence: true 
  validates :email, presence: true 
  validates :first_name, presence: true
  validates :last_name, presence: true 
  validates :password, length: { minimum: 8 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :email, uniqueness: true
	validates :username, uniqueness: true

end
