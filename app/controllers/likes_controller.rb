class LikesController < ApplicationController
	before_action :identify_user
	before_action :identify_likeable, only: [:create, :destroy]
	before_action :identify_likeable_user, only: [:create, :destroy]
	before_action :create_like, only: [:create]
	before_action :identify_like, only: [:destroy]

	#liking should redirect to the profile page of the post's creator

	def create
		if @like.save
			flash[:success] = "Liked!"
		else
			flash[:error] = "Error! Unable to like!"
		end

		redirect_to user_path(@likeable_user)
	end

	def destroy
		@like.destroy
		flash[:success] = "Unliked!"

		redirect_to user_path(@likeable_user)
	end

	private
		def identify_user
			@user = current_user
		end

		def identify_likeable
			if params[:post_id]
				@post = Post.find(params[:post_id])
			elsif params[:comment_id]
				@comment = Comment.find(params[:comment_id])
				@post = @comment.post
			end
		end

		def create_like
			if params[:post_id]
				@like = @post.likes.build(user_id: @user.id)
			elsif params[:comment_id]
				@like = @comment.likes.build(user_id: @user.id)
			end
		end

		def identify_like
			if params[:post_id]
				@like = @post.likes.find_by(user_id: @user.id)
			elsif params[:comment_id]
				@like = @comment.likes.find_by(user_id: @user.id)
			end
		end

		def identify_likeable_user
			@likeable_user = @post.user
		end

end
