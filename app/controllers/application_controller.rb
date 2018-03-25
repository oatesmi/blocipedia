class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pundit
  # before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

private

  def user_not_authorized
    flash[:alert] = "You are not authorized to do this."
    if current_user
      redirect_to request.referrer
    else
      redirect_to(new_user_session_path)
    end
  end 


end
