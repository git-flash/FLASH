# frozen_string_literal: true

# Event model
class Event < ApplicationRecord
  belongs_to :committee
  has_many :attendance_logs, dependent: :destroy
  has_many :rsvps, dependent: :destroy
  has_many :attendants, class_name: 'User', through: :attendance_logs, source: :user
  has_many :rsvp_users, class_name: 'User', through: :rsvps, source: :user

  # @param [DateTime] start_date
  # @return [ActiveRecord::Relation] This is a list of all events for a given month.
  scope :month, lambda { |start_date|
    where(start_timestamp: start_date.change(year: 1000)..start_date.end_of_month.end_of_week)
      .and(where(end_timestamp: start_date.beginning_of_month.beginning_of_week..))
  }

  # @param [DateTime] start_date
  # @return [ActiveRecord::Relation] This is a list of all events for a given day.
  scope :day, lambda { |date|
    where(start_timestamp: date.change(year: 1000)..date.end_of_day).and(where(end_timestamp: date.beginning_of_day..))
  }

  validates :name, presence: true, length: { minimum: 1 }
  validates :start_timestamp, presence: true
  validates :end_timestamp, presence: true
  validate :end_must_be_after_start
  validates :point_value, presence: true
  validates :passcode, presence: true, length: { minimum: 1 }

  def end_must_be_after_start
    errors.add(:start_timestamp, "can't start after it ends.") unless start_timestamp <= end_timestamp
  end

  # @return [boolean] whether or not an event is active
  def active?
    start_timestamp < DateTime.current && end_timestamp > DateTime.current
  end

  # @return [boolean] whether or not an event is active
  def in_future?
    start_timestamp > DateTime.current
  end
end
