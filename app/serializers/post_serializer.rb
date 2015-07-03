class PostSerializer < ActiveModel::Serializer
	include Rails.application.routes.url_helpers

  attributes :title, :body, :summary, :created_at, :url

  has_one :user

  def url
  	post_url(object)
  end
end
