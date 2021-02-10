class AttendanceLog < ApplicationRecord
  belongs_to :user
  belongs_to :event

  before_save :check_user
  before_destroy :check_user

  def check_user
    authenticate_user!
    unless current_user.id == self.user_id || current_user.check_staff?
      redirect_to :root_path, alert: "You do not have permissions"
    end
  end

  validate :passcode, inclusion: { in: [self.event.passcode], message: "Passcode does not match" }
end
