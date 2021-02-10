class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :trackable
  belongs_to :committee, optional: true
  has_many :rsvps
  has_many :attendance_logs

  validates :first_name, length: { minimum: 1 }
  validates :last_name, length: { minimum: 1 }
  validates :user_type, numericality: { greater_than_or_equal_to: 0 }
  validates :uin, numericality: { only_integer: true, greater_than_or_equal_to: 100000000, less_than_or_equal_to: 999999999 }
end
