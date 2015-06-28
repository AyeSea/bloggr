class UsersController < ApplicationController
	before_action :authenticate_user!

	def index
		#Show all users who are not your friends.
		@non_friends = User.all - current_user.friends
		@non_friends.delete(current_user)
	end

	def show
		@user = User.find(params[:id])
		@post = @user.posts.build
		@comment = Comment.new
	end

end
