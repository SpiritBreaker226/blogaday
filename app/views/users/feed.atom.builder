atom_feed do |feed|
  feed.title "#{@user.full_name}'s Blog"
  feed.updated @posts.maximum(:created_at)

  @posts.each do |post|
    feed.entry post, { published: post.created_at, updated: post.updated_at } do |entry|
      entry.title post.title
      entry.content post.body, type: 'markdown'
      
      entry.author do |author|
        author.name post.user.full_name
      end

      entry.url post_url(post)
      entry.summary post.summary
    end
  end
end