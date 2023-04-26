class FriendshipsController < ApplicationController
  before_action :require_login
  def create
    @user = User.find(params[:friend_id])
    @followings = Friendship.where(friend_id: @user.id).count
    @followers = Friendship.where(user_id: @user.id).count
    current_user.add_friend!(@user)
  end

  def destroy
    @user = User.find(params[:friend_id])
    @followings = Friendship.where(friend_id: @user.id).count
    @followers = Friendship.where(user_id: @user.id).count
    current_user.remove_friend!(@user)
  end
end
