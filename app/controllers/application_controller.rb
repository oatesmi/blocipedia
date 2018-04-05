class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pundit

  # before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def current_or_guest_user
    if current_user
      if session[:guest_user_id] && session[:guest_user_id] != current_user.id
        guest_user(with_retry = false).try(:reload).try(:destroy)
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end

  def guest_user(with_retry = true)
    @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)


  rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
    session[:guest_user_id] = nil
    guest_user if with_retry
  end

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
        redirect_to wikis_path
      else
        redirect_to(new_user_session_path)
      end
    end

    def create_guest_user
      u = User.new(:name => "guest", :email => "guest_#{Time.now.to_i}#{rand(100)}@example.com")
      u.save!(:validate => false)
      session[:guest_user_id] = u.id
      u
    end
end
