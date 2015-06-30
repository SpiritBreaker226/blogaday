module UsersHelper
	def user_author_any_post?(user_auther_posts)
		return (user_auther_posts.length > 0) ? true : false
	end
end
