class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  def index
    @users = user_signed_in? ? User.all.where.not(id: current_user.id) :  User.all
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
