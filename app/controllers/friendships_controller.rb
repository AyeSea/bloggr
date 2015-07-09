class FriendshipsController < ApplicationController
	before_action :authenticate_user!

	def index
	end

	#show pending friendships
	def show
		@pending_friendships = current_user.accepting_friendships.where("accepted = ?", false)
	end

	#send a friend request
	def create
		@friendship = current_user.requesting_friendships.build(accepter_id: params[:accepter_id])
		if @friendship.save
			flash[:success] = "Friend request sent!"
		else
			flash[:error] = "Error! Friend request could not be sent!"
		end

		redirect_to :back
	end

	#Accept a friend request (i.e. pending friendship) changes the value of the accepted column to true.
	def update
		@friendship = current_user.accepting_friendships.find_by(requester_id: params[:requester_id])
		@friend = User.find(params[:requester_id])
		
		@friendship.update_attribute(:accepted, true)
		flash[:success] = "Added #{@friend.first_name} #{@friend.last_name}!"
		redirect_to user_posts_path(@friend)
	end

	#Reject a friend request (i.e. pending friendship) or remove an existing friendship.
	def destroy
		@friend = User.find(params[:friend_id])

		if current_user.requesters.include?(@friend)
			#delete friendship. this means that you accepted the friendship. works for both accepted and not accepted friend requests.
			@friendship = current_user.accepting_friendships.where("requester_id = ?", @friend.id)
			@friendship.destroy(@friendship)
		elsif
			#delete friendship. this means that you requested the friendship. works for both accepted and not accepted friend requests.
			@friendship = current_user.requesting_friendships.where("accepter_id = ?", @friend.id)
			@friendship.destroy(@friendship)
		end

		flash[:success] = "Removed friend!"
		redirect_to users_path
	end
end
