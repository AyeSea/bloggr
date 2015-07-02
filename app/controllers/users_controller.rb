class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :identify_user, only: :show
	before_action :authorize_home_view, only: :show
	#restrict home page to that page's owner only

	def index
		#Show all users who are not your friends.
		@non_friends = User.all - current_user.friends
		@non_friends.delete(current_user)
	end

	def show
		identify_user

		#Post instance needed for the post_form partial.
		@post = Post.new

		#Show posts for user and all of user's friends.
		@user_posts = @user.posts
		@friends_posts = []

		#Iterate through user's friends and add each friend's collection of posts to the @friends_posts array.
		@user.friends.each { |friend| @friends_posts << friend.posts }

		#Flatten the @friends_posts array so that each element is an individual post.
		@friends_posts = @friends_posts.flatten

		#A user's posts consists of his/her own posts and his/her friend's posts. Sort these by the created_at date and reverse
		#so they are in descending order.
		@posts = (@user_posts + @friends_posts).sort_by { |post| post[:created_at] }.reverse
	end

	private
		def identify_user
			@user = User.find(params[:id])
		end

		def authorize_home_view
			unless current_user == @user
				flash[:error] = "Unauthorized Access - Cannot view another user's landing page"
				redirect_to current_user
			end
		end

end
