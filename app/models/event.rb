class Event < ApplicationRecord
  belongs_to :committee

  before_save :check_user
  before_destroy :check_user

  def check_user
    authenticate_user!
    unless current_user.check_staff?
      redirect_to :root_path, alert: "You do not have permissions"
    end
  end
end
