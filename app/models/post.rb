class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true 
  validates :summary, length: { maximum: 140 }
  validates :body, length: { minimum: 250 }

  def self.display_and_order_by_publish_date
    Post.all.where('publish_date IS NOT NULL').where('publish_date <= ?', Time.now).order(publish_date: :desc)
  end

  def get_frist_sentence
  	render_plaintext_body = render_markdown_post_to_html(plaintext_instead: true)
  	first_sentence_end_index = render_plaintext_body.include?(".") ? render_plaintext_body.index('.') : 139

  	render_plaintext_body[0..first_sentence_end_index]
  end

  def render_markdown_post_to_html(plaintext_instead: false)
  	plaintext_instead == false ? GitHub::Markdown.render_gfm(body) : GitHub::Markdown.to_html(body, :plaintext)
  end
end
