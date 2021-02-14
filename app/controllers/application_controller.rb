class ApplicationController < ActionController::Base
  #noinspection RailsParamDefResolve
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :uin, :user_type])
  end

  protected

  def confirm_logged_in
    redirect_to_login unless user_signed_in?
  end

  def confirm_staff
    redirect_to_home unless user_signed_in? && current_user.check_staff?
  end

  def confirm_exec
  end

  def redirect_to_home
    redirect_to root_path, alert: 'You do not have permissions'
  end

  def redirect_to_login
    redirect_to new_user_session_path, alert: 'You do not have permissions'
  end
    
end
