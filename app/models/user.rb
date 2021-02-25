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
  has_many :events, through: :rsvps, source: :rsvps_table_foreign_key_to_events_table
  has_many :events, through: :attendance_logs, source: :attendance_logs_table_foreign_key_to_events_table

  validates :first_name, length: { minimum: 1 }
  validates :last_name, length: { minimum: 1 }
  validates :uin, numericality: { only_integer: true, greater_than_or_equal_to: 100000000, less_than_or_equal_to: 999999999 }, uniqueness: true

  # @return points for a user for a specific committee
  scope :points_for_committee, ->(user, point_committee) {
    select("SUM(events.point_value) as total_points")  
      .joins("INNER JOIN attendance_logs ON attendance_logs.user_id = users.id")
      .joins("INNER JOIN events ON attendance_logs.event_id = events.id")
      .where("events.committee_id = ?", point_committee.id)
      .where("users.id = ?", user.id)
  }

  # @return all base users
  scope :freshman, -> () {
    where("users.user_type < ?", user_types[:staff])
  }
end
