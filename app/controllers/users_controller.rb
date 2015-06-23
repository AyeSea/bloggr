class UsersController < ApplicationController
	before_action :authenticate_user!

	def index
		#Show all users who are not your friends.
		@non_friends = User.all - current_user.friends
	end

	def show
		@user = User.find(params[:id])
	end

end
