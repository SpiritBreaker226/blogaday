class Post < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true 
  validates :body, length: { minimum: 250 }

  def get_frist_sentence
  	first_sentence_end_index = body.include?(".") ? body.index('.') : 139

  	body[0..first_sentence_end_index]
  end

  def render_markdown_post_to_html(plaintext_instead: false)
  	plaintext_instead == false ? GitHub::Markdown.render_gfm(body) : GitHub::Markdown.to_html(body, :plaintext)
  end
end
