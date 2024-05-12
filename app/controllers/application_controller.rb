class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
  end

  def manager_users?
    if current_user.role == "guest"
      flash[:danger] = "Only allow manager"
      redirect_to root_path
    end
  end

  def admin_users?
    if current_user.role != "admin"
      flash[:danger] = "Only allow admin"
      redirect_to root_path
    end
  end

  def already_logged_in?
    unless user_signed_in?
      flash[:danger] = "You must login first!"
      redirect_to new_user_session_path
    end
  end
end
