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
		@post = @user.posts.build
		@comment = Comment.new
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
