class Committee < ApplicationRecord
  has_many :users
  has_many :events

  scope :committee_points, -> { joins("LEFT JOIN events ON events.committee_id = committees.id") }

  scope :social_points, ->(committee_id) { 
  select("SUM(events.point_value) as total_points")  
    .joins("INNER JOIN users ON users.committee_id = committees.id")
    .joins("INNER JOIN attendance_logs ON attendance_logs.user_id = users.id")
    .joins("INNER JOIN events ON attendance_logs.event_id = events.id")
    .where("events.committee_id = 1")
    .where("committees.id = ?", committee_id)
  }

  scope :fundraising_points, ->(committee_id) { 
  select("SUM(events.point_value) as total_points")  
    .joins("INNER JOIN users ON users.committee_id = committees.id")
    .joins("INNER JOIN attendance_logs ON attendance_logs.user_id = users.id")
    .joins("INNER JOIN events ON attendance_logs.event_id = events.id")
    .where("events.committee_id = 2")
    .where("committees.id = ?", committee_id)
  }

  scope :campus_relations_points, ->(committee_id) { 
  select("SUM(events.point_value) as total_points")  
    .joins("INNER JOIN users ON users.committee_id = committees.id")
    .joins("INNER JOIN attendance_logs ON attendance_logs.user_id = users.id")
    .joins("INNER JOIN events ON attendance_logs.event_id = events.id")
    .where("events.committee_id = 3")
    .where("committees.id = ?", committee_id)
  }

  scope :pr_points, ->(committee_id) { 
  select("SUM(events.point_value) as total_points")  
    .joins("INNER JOIN users ON users.committee_id = committees.id")
    .joins("INNER JOIN attendance_logs ON attendance_logs.user_id = users.id")
    .joins("INNER JOIN events ON attendance_logs.event_id = events.id")
    .where("events.committee_id = 4")
    .where("committees.id = ?", committee_id)
  }

  scope :community_outreach_points, ->(committee_id) { 
  select("SUM(events.point_value) as total_points")  
    .joins("INNER JOIN users ON users.committee_id = committees.id")
    .joins("INNER JOIN attendance_logs ON attendance_logs.user_id = users.id")
    .joins("INNER JOIN events ON attendance_logs.event_id = events.id")
    .where("events.committee_id = 5")
    .where("committees.id = ?", committee_id)
  }

  scope :give_back_points, ->(committee_id) { 
  select("SUM(events.point_value) as total_points")  
    .joins("INNER JOIN users ON users.committee_id = committees.id")
    .joins("INNER JOIN attendance_logs ON attendance_logs.user_id = users.id")
    .joins("INNER JOIN events ON attendance_logs.event_id = events.id")
    .where("events.committee_id = 6")
    .where("committees.id = ?", committee_id)
  }
end
