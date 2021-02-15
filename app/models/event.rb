class Event < ApplicationRecord
  belongs_to :committee
  has_many :users, through: :attendance_logs, source: :attendance_logs_table_foreign_key_to_objects_table
  has_many :users, through: :rsvps, source: :rsvps_table_foreign_key_to_objects_table
end
