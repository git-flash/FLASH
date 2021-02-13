# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

committee_names = ["Social", "Fundraising", "Campus Relations", "Public Relations", "Community Outreach", "Give Back"]

committee_names.each { |name|
  Committee.create!(name: name)
}

if Rails.env.development?
  User.create!(first_name: "Test", last_name: "Admin", uin: 100000000, user_type: :admin, email: "test@test.test", password: "AdminPassword")
end
