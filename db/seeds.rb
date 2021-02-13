# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

committee_names = ["Social", "Fundraising", "Campus Relations", "Public Relations", "Community Outreach", "Give Back"]
committees = []

committee_names.each { |name|
  committees.push(Committee.create!(name: name))
}

if Rails.env.development?
  User.create!(first_name: "Test", last_name: "Admin", uin: 100000000, user_type: :admin, email: "admin@test.com", password: "AdminPassword")
  User.create!(first_name: "Test", last_name: "Executive", uin: 100000000, user_type: :executive, email: "exec@test.com", password: "ExecPassword")
  User.create!(first_name: "Test", last_name: "Staff", uin: 100000000, user_type: :staff, email: "staff@test.com", password: "StaffPassword", committee: committees[0])
  User.create!(first_name: "Test", last_name: "User", uin: 100000000, user_type: :base, email: "user@test.com", password: "UserPassword", committee: committees[0])
end
