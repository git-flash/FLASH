class ApplicationController < ActionController::Base
  #noinspection RailsParamDefResolve
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :uin, :user_type])
  end

  protected

    def confirm_logged_in
      if user_signed_in?
        true
      else
        :redirect_to_login
      end
    end

    def confirm_staff
      if user_signed_in? && current_user.check_staff?
        true
      else
        :redirect_to_login
      end
    end

    def confirm_exec
    end

    def redirect_to_login
      redirect_to new_user_session_path, alert: 'You do not have permissions'
    end
    
end
