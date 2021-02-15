class ApplicationController < ActionController::Base
  #noinspection RailsParamDefResolve
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :uin, :user_type])
  end

  protected def confirm_logged_in
    unless user_signed_in?
      :redirect_to_login
    end
  end

  protected def confirm_staff
    unless user_signed_in? && current_user.check_staff?
      :redirect_to_login
    end
  end

  protected def confirm_exec
    unless user_signed_in? && current_user.check_executive?
      :redirect_to_login
    end
  end

  protected def confirm_admin
    unless user_signed_in? && current_user.check_admin?
      :redirect_to_login
    end
  end

  protected def redirect_to_login
    redirect_to root_path, alert: 'You do not have permissions'
  end
end
