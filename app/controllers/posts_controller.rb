class PostsController < ApplicationController
	before_action :identify_user, only: [:index, :create, :destroy]

	def index
		@posts = @user.posts
		#Post instance needed for the post_form partial.
		@post = Post.new
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
			@user = User.find(params[:user_id]) || User.find(params[:current_user_id])
		end

		def post_params
			params.require(:post).permit(:content)
		end
end
