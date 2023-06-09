# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  def edit
    @avatars = Avatar.all
    super
  end

  def update
    @user = current_user
    avatars =  Avatar.all
    @avatars = avatars

    avatars.each do |avatar|
      if avatar.id == params[:user][:avatar_id]
        @user.avatar = avatar
        break # exit the loop once the Avatar object is found
      end
    end

    if @user.valid_password?(params[:user][:current_password])
      if @user.update(user_params)
        redirect_to @user, notice: 'User was successfully updated.'
      else
        flash[:error] = @user.errors.full_messages.join(", ")
        render :edit
      end
    else
      @user.errors.add(:current_password, 'is incorrect')
      render :edit
    end
  end

  private

  def user_params
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params.require(:user).permit(:name, :username, :email, :current_password, :avatar_id)
    else
      params.require(:user).permit(:name,  :username,
                                   :email, :password,
                                   :password_confirmation,
                                   :current_password,
                                   :avatar_id)
    end
  end
end

