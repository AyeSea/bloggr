class CommentsController < ApplicationController

	def create
		@comment = Comment.new(comment_params)
		@post = @comment.post
		@user = @post.user

		if @comment.save
			flash[:success] = "Comment added!"
			redirect_to @user
		else
			flash[:error] = "Error! Comment could not be added!"
			render @user
		end
	end

	def destroy	
		@comment = Comment.find(params[:id])
		@post = @comment.post
		@user = @post.user

		@comment.destroy
		flash[:success] = "Comment removed!"
		redirect_to @user
	end

	private
		def comment_params
			params.require(:comment).permit(:content, :post_id, :user_id)
		end

end
