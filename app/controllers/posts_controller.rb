class PostsController < ApplicationController
	before_action :identify_user, only: [:create, :destroy]

	def create
		@post = @user.posts.build(post_params)
		if @post.save
			flash[:success] = "You added a new post to your wall!"
		else
			flash[:error] = "Error! You couldn't add a new post!"
		end

		redirect_to @user
	end

	def destroy
		@post = @user.posts.find(params[:id])
		@post.destroy
		flash[:success] = "Post removed!"
		redirect_to @user
	end

	private
		def identify_user
			@user = User.find(params[:user_id])
		end

		def post_params
			params.require(:post).permit(:content)
		end
end
