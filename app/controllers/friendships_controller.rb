class FriendshipsController < ApplicationController
  before_action :require_login
  def create
    @user = User.find(params[:friend_id])
    current_user.follow!(@user)
  end

  def destroy
    @user = User.find(params[:friend_id])
    current_user.unfollow!(@user)
  end
end
