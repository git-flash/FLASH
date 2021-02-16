class Event < ApplicationRecord

  # scope :current, -> { where(event.start_timestamp >= Date.today) }
  # Ex:- scope :active, -> {where(:active => true)}

  belongs_to :committee
  has_many :users, through: :attendance_logs, source: :attendance_logs_table_foreign_key_to_objects_table
  has_many :users, through: :rsvps, source: :rsvps_table_foreign_key_to_objects_table
end
