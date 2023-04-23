# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  def edit
    @avatars = Avatar.all
    super
  end

  def update
    @user = current_user
    @avatars = Avatar.all
    if @user.valid_password?(params[:user][:current_password])
      if @user.update(user_params)
        redirect_to @user, notice: 'User was successfully updated.'
      else
        flash[:error] = @user.errors.full_messages.join(", ")
        render :edit
      end
    else
      @user.errors.add(:current_password, "is incorrect")
      render :edit
    end
  end

  private

  def user_params
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params.require(:user).permit(:name, :username, :email,:current_password)
    else
      params.require(:user).permit(:name, :username, :email, :password, :password_confirmation, :current_password)
    end
  end
end

