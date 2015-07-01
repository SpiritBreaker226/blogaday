class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :username, presence: true 
  validates :email, presence: true 
  validates :first_name, presence: true
  validates :last_name, presence: true 
  validates :password, length: { minimum: 8 }, unless: :password_blank?
  validates :password, format: { with: /\d+/ }, unless: :password_blank?
  validates :password, format: { with: /[a-z]+/ }, unless: :password_blank?
  validates :password, format: { with: /[A-Z]+/ }, unless: :password_blank?
  validates :password, confirmation: true
  validates :password_confirmation, presence: true, on: :create, unless: :password_blank?
  validates :email, uniqueness: true
	validates :username, uniqueness: true

  def full_name
    "#{first_name} #{last_name}"
  end

	def password_blank?
    password.blank?
  end
end
