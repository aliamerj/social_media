class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def index
    @users = user_signed_in? ? User.all.where.not(id: current_user.id) :  User.all
  end
end
