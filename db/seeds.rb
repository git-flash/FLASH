# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env.development?
  test_committee = Committee.create!(name: "Test Committee")

  User.create!(first_name: "Test", last_name: "Admin", uin: 100000001, user_type: :admin, email: "admin@test.com", password: "AdminPassword")
  User.create!(first_name: "Test", last_name: "Executive", uin: 100000002, user_type: :executive, email: "exec@test.com", password: "ExecPassword")
  User.create!(first_name: "Test", last_name: "Staff", uin: 100000003, user_type: :staff, email: "staff@test.com", password: "StaffPassword", committee: test_committee)
  test_user1 = User.create!(first_name: "Test", last_name: "User", uin: 100000004, user_type: :base, email: "user@test.com", password: "UserPassword", committee: test_committee)
  test_user2 = User.create!(first_name: "Cool", last_name: "User", uin: 100000004, user_type: :base, email: "cool_user@test.com", password: "UserPassword", committee: test_committee)

  test_event1 = Event.create!(name: "Sprint 1 Megapalooza", start_timestamp: Time.now, end_timestamp: Time.now, location: "HRBB 124", committee: test_committee, point_value: 1, passcode: "1234")
  test_event2 = Event.create!(name: "Cole's Wild Party", start_timestamp: Time.now, end_timestamp: Time.now, location: "HRBB 124", committee: test_committee, point_value: 1, passcode: "1234")
  test_event3 = Event.create!(name: "FLASH FEST 2021", start_timestamp: Time.now, end_timestamp: Time.now, location: "HRBB 124", committee: test_committee, point_value: 1, passcode: "1234")

  AttendanceLog.create!(user: test_user1, event: test_event1, passcode: "1234")
  AttendanceLog.create!(user: test_user1, event: test_event2, passcode: "1234")
  AttendanceLog.create!(user: test_user1, event: test_event3, passcode: "1234")

  AttendanceLog.create!(user: test_user2, event: test_event1, passcode: "1234")
  AttendanceLog.create!(user: test_user2, event: test_event2, passcode: "1234")
  AttendanceLog.create!(user: test_user2, event: test_event3, passcode: "1234")
end

committee_names = ["Social", "Fundraising", "Campus Relations", "Public Relations", "Community Outreach", "Give Back"]
committees = []

committee_names.each { |name|
  committees.push(Committee.create!(name: name))
}
