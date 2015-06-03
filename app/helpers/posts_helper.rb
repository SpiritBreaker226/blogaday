module PostsHelper
	def display_summary(post)
		if post.summary.nil? || post.summary.empty?
			post.get_frist_sentence
		else
			post.summary
		end
	end
end
