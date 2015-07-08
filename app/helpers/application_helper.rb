module ApplicationHelper

	def ordered_posts(user)
		@user_posts = user.posts
		@friends_posts = []

		#Iterate through user's friends and add each friend's collection of posts to the @friends_posts array.
		user.friends.each { |friend| @friends_posts << friend.posts }

		#Flatten the @friends_posts array so that each element is an individual post.
		@friends_posts = @friends_posts.flatten

		#A user's posts consists of his/her own posts and his/her friend's posts. Sort these by the created_at date and reverse
		#so they are in descending order.
		@posts = (@user_posts + @friends_posts).sort_by { |post| post[:created_at] }.reverse
	end


	def bootstrap_flash_class(flash_type)
		{ success: 'alert-success',
		  error:   'alert-danger',
		  alert:   'alert-warning',
		  notice:  'alert-info'
		}[flash_type.to_sym] || flash_type.to_s
	end
	
end
