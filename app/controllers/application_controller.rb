class ApplicationController < ActionController::Base
  #noinspection RailsParamDefResolve
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :uin, :user_type])
  end
end
