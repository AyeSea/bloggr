class PostsController < ApplicationController
	before_action :identify_user, only: [:index, :create, :destroy]

	def index
		@user_posts = @user.posts

		@friends_posts = []

		#Iterate through user's friends and add each friend's collection of posts to the @friends_posts array.
		@user.friends.each do |friend|
			@friends_posts << friend.posts
		end

		#Flatten the @friends_posts array so that each element is an individual post.
		@friends_posts = @friends_posts.flatten

		#A user's posts consists of his/her own posts and his/her friend's posts.
		@posts = @user_posts + @friends_posts
	end

	def create
		@post = @user.posts.build(post_params)
		if @post.save
			flash[:success] = "You added a new post to your wall!"
		else
			flash[:error] = "Error! You couldn't add a new post!"
		end

		redirect_to :back
	end

	def destroy
		@post = @user.posts.find(params[:id])
		@post.destroy
		flash[:success] = "Post removed!"
		redirect_to :back
	end

	private
		def identify_user
			@user = User.find(params[:user_id])
		end

		def post_params
			params.require(:post).permit(:content)
		end
end
