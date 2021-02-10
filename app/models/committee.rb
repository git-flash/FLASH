class Committee < ApplicationRecord
  has_many :users
  has_many :events

  before_save :check_user
  before_destroy :check_user

  def check_user
    authenticate_user!
    unless current_user.check_executive?
      redirect_to :root_path, alert: "You do not have permissions"
    end
  end
end
