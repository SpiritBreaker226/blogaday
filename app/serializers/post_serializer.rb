class PostSerializer < ActiveModel::Serializer
  attributes :title, :body, :summary, :created_at

  belongs_to :user
end
