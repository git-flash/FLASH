class User < ApplicationRecord
  enum user_type: {base: 0, staff: 10, executive: 20, admin: 30}
  after_initialize :set_default_user_type, :if => :new_record?

  private def set_default_user_type
    self.user_type ||= :base
  end

  def check_admin?
    self.admin?
  end

  def check_executive?
    self.executive? || self.check_admin?
  end

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
end
