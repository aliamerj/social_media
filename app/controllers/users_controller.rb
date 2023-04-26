class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @followings = Friendship.where(friend_id: @user.id).count
    @followers = Friendship.where(user_id: @user.id).count
  end

  # def edit
  #   @user = current_user
  #   @avatars = Avatar.all
  # end

  # def update
  #   @user = current_user
  #   @avatars = Avatar.all
  #   if @user.update(user_params)
  #     redirect_to @user, notice: 'User was successfully updated.'
  #   else
  #     render :edit
  #   end
  # end

  # private

  # def user_params
  #   params.require(:user).permit(:name, :email, :password, :password_confirmation)
  # end

end
