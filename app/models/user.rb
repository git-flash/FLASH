class User < ApplicationRecord
  enum user_type: [:base, :staff, :executive, :admin]
  after_initialize :set_default_user_type, :if => :new_record?

  private def set_default_user_type
    self.user_type ||= :base
  end

  def check_admin?
    self.user_type >= :admin
  end

  def check_executive?
    self.user_type >= :executive
  end

  def check_staff?
    self.user_type >= :staff
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
  has_many :rsvps
  has_many :attendance_logs

  validates :first_name, length: { minimum: 1 }
  validates :last_name, length: { minimum: 1 }
  validates :uin, numericality: { only_integer: true, greater_than_or_equal_to: 100000000, less_than_or_equal_to: 999999999 }
end
