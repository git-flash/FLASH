class Committee < ApplicationRecord
  has_many :users
  has_many :events

  scope :point_total, ->(committee_id, point_type) { 
    point_type_map = { "social" => 1, "fundraising" => 2, "campus_relations" => 3, "pr" => 4, "community_outreach" => 5, "give_back" => 6 }

    select("SUM(events.point_value) as total_points")  
      .joins("INNER JOIN users ON users.committee_id = committees.id")
      .joins("INNER JOIN attendance_logs ON attendance_logs.user_id = users.id")
      .joins("INNER JOIN events ON attendance_logs.event_id = events.id")
      .where("events.committee_id = ?", point_type_map[point_type])
      .where("committees.id = ?", committee_id)
  }
end
