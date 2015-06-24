class LikesController < ApplicationController
	before_action :identify_user
	before_action :identify_post

	def create
		@like = @post.likes.build(user_id: @user.id)

		if @like.save
			flash[:success] = "Post was liked!"
		else
			flash[:error] = "Error! Unable to like this post!"
		end

		redirect_to user_path(@post.user)
	end

	def destroy
		@like = @post.likes.find_by(user_id: @user.id)
		@like.destroy
		flash[:success] = "Post was unliked!"

		redirect_to user_path(@post.user)
	end

	private
		def identify_user
			@user = current_user
		end

		def identify_post
			@post = Post.find(params[:post_id])
		end
end
