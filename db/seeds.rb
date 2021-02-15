# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# seed committees
committee_names = ["Social", "Fundraising", "Campus Relations", "Public Relations", "Community Outreach", "Give Back"]
committees = []

committee_names.each { |name|
  committees.push(Committee.create!(name: name))
}

# seeds for dev environment
if Rails.env.development?
  test_committee = Committee.create!(name: "Test Committee")

  # seed development users
  User.create!(first_name: "Test", last_name: "Admin", uin: 100000001, user_type: :admin, email: "admin@test.com", password: "AdminPassword")
  User.create!(first_name: "Test", last_name: "Executive", uin: 100000002, user_type: :executive, email: "exec@test.com", password: "ExecPassword")
  User.create!(first_name: "Test", last_name: "Staff", uin: 100000003, user_type: :staff, email: "staff@test.com", password: "StaffPassword", committee: test_committee)
  User.create!(first_name: "Test", last_name: "User", uin: 100000004, user_type: :base, email: "user@test.com", password: "UserPassword", committee: test_committee)

  # seed development events
  Event.create!(name: 'Social Event', committee_id: Committee.find_by(name: 'Social').id, start_timestamp: Date.today, end_timestamp: Date.today, location: "HQ", point_value: 1, passcode: 'social')
  Event.create!(name: 'Fundraising Event', committee_id: Committee.find_by(name: 'Fundraising').id, start_timestamp: Date.today, end_timestamp: Date.today, location: "HQ", point_value: 1, passcode: 'funds')
  Event.create!(name: 'Give Back Event', committee_id: Committee.find_by(name: 'Give Back').id, start_timestamp: Date.today, end_timestamp: Date.today, location: "HQ", point_value: 1, passcode: 'giver')
end
