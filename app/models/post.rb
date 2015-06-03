class Post < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true 
  validates :summary, length: { maximum: 140 }
  validates :body, length: { minimum: 250 }

  def get_frist_sentence
  	render_plaintext_body = render_markdown_post_to_html(plaintext_instead: true)
  	first_sentence_end_index = render_plaintext_body.include?(".") ? render_plaintext_body.index('.') : 139

  	render_plaintext_body[0..first_sentence_end_index]
  end

  def render_markdown_post_to_html(plaintext_instead: false)
  	plaintext_instead == false ? GitHub::Markdown.render_gfm(body) : GitHub::Markdown.to_html(body, :plaintext)
  end
end
