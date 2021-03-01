class ApplicationController < ActionController::Base
  #noinspection RailsParamDefResolve
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :uin, :user_type])
  end

  protected def after_sign_out_path_for(resource_or_scope)
    new_user_session_url
  end

  protected

  def confirm_logged_in(message = nil)
    redirect_to_login(message) unless user_signed_in?
  end

  def confirm_staff(message = nil)
    redirect_to_home(message) unless user_signed_in? && current_user.check_staff?
  end

  def confirm_event_staff(event, message = nil)
    redirect_to_home(message) unless user_signed_in? && current_user.check_staff? && (current_user.committee_id.eql? event.committee_id)
  end

  def confirm_exec(message = nil)
    redirect_to_home(message) unless user_signed_in? && current_user.check_executive?
  end

  def confirm_admin(message = nil)
    redirect_to_home(message) unless user_signed_in? && current_user.check_admin?
  end

  def redirect_to_home(message = nil)
    redirect_to root_path, alert: message == nil ? 'You do not have permissions' : message
  end

  def redirect_to_login(message = nil)
    redirect_to new_user_session_path, alert: message == nil ? 'You do not have permissions' : message
  end
    
end
