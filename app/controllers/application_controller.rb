# Application Controller
class ApplicationController < ActionController::Base
  include FriendshipsHelper
  # include helpers
  include AuthsHelper

  before_action :configure_permitted_params, if: :devise_controller?

  protected

  def configure_permitted_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end
