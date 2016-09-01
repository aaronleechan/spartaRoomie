class FriendsController < ApplicationController
	before_action :authenticate_user!

	def index
		@myfriends = Array.new
		friends = current_user.friends
		if friends != nil
			friends.each do |theFriendship|
				@myfriends << User.find(theFriendship.friend_id)
			end
		end
	end

	def new
		@friendship1 = Friendship.new
		@friendship2 = Friendship.new
	end

	def create
		@user = User.find(current_user)
		@friend = User.find(params[:friend_id])

		@friendship1 = Friendship.create(user_id: current_user.id, friend_id: @friend.id, status: "requested")
		@friendship2 = Friendship.create(user_id: @friend.id, friend_id: current_user.id, status: "pending")

		if @friendship1.save && @friendship2.save
			redirect_to @friend
		else
			redirect_to @friend
		end
	end

	def pending_friends
		@pending_friends = Array.new
		pending = current_user.pending_friends
		if pending != nil
			pending.each do |theFriendship|
				@pending_friends << User.find(theFriendship.friend_id)
			end
		end
	end

	def requested_friends
		@requested_friends = Array.new
		requested = current_user.requested_friends
		if requested != nil
			requested.each do |theFriendship|
				@requested_friends << User.find(theFriendship.friend_id)
			end
		end
	end

	def update
		@user = User.find(current_user)
		@friend = User.find(params[:friend_id])

		@friendship1 = Friendship.find_by_user_id_and_friend_id(@user.id, @friend.id)
		@friendship2 = Friendship.find_by_user_id_and_friend_id(@friend.id, @user.id)

		if @friendship1.update_attributes(user_id: @user.id, friend_id: @friend.id, status: "accepted") && @friendship2.update_attributes(user_id: @friend.id, friend_id: @user.id, status: "accepted")
			redirect_to @friend
		else
			redirect_to @friend
		end
	end

	def destroy
		@user = User.find(current_user)
		@friend = User.find(params[:friend_id])

		@friendship1 = Friendship.find_by_user_id_and_friend_id(@user.id, @friend.id).destroy
		@friendship2 = Friendship.find_by_user_id_and_friend_id(@friend.id, @user.id).destroy
		redirect_to root_url
	end
end