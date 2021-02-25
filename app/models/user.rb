class User < ApplicationRecord
  # The types that a user can be
  enum user_type: { base: 0, staff: 10, executive: 20, admin: 30 }
  after_initialize :set_default_user_type, :if => :new_record?

  # Sets the current user to base if unassigned
  private def set_default_user_type
    self.user_type ||= :base
  end

  # @return true if admin or greater, false otherwise
  def check_admin?
    self.admin?
  end

  # @return true if exec or greater, false otherwise
  def check_executive?
    self.executive? || self.check_admin?
  end

  # @return true if staff or greater, false otherwise
  def check_staff?
    self.staff? || self.check_executive?
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :trackable,
         stretches: 12
  belongs_to :committee, optional: true
  has_many :attendance_logs
  has_many :rsvps
  has_many :attended_events, class_name: 'Event', through: :attendance_logs, source: :event
  has_many :rsvp_events, class_name: 'Event', through: :rsvps, source: :event

  validates :first_name, length: { minimum: 1 }
  validates :last_name, length: { minimum: 1 }
  validates :uin, numericality: { only_integer: true, greater_than_or_equal_to: 100000000, less_than_or_equal_to: 999999999 }, uniqueness: true

  # @param [Committee] point_committee
  # @return [Integer] the points this user has for a certain committee
  def points_for_committee(point_committee)
    attended_events.where(committee: point_committee).sum(:point_value)
  end

  # @return [Integer] The total points for this user
  def total_points
    attended_events.sum(:point_value)
  end

  # @return all base users
  scope :freshman, -> () {
    where(user_type: :base)
  }
end
