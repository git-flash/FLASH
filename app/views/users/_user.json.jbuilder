json.extract! user, :id, :first_name, :last_name, :uin, :user_type, :committee_id, :created_at, :updated_at
json.url user_url(user, :format => :json)
