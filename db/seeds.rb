# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

social_committee = Committee.create!(:name => "Social")                        # Committee Id 1
fundraising_committee = Committee.create!(:name => "Fundraising")               # Committee Id 2
campus_relations_committee = Committee.create!(:name => "Campus Relations")     # Committee Id 3
pr_committee = Committee.create!(:name => "Public Relations")                   # Committee Id 4
community_outreach_committee = Committee.create!(:name => "Community Outreach") # Committee Id 5
give_back_committee = Committee.create!(:name => "Give Back")                   # Committee Id 6

User.create!(:first_name => "Temp", :last_name => "Admin", :uin => 100000000, :user_type => :admin, :email => "temp@admin.com", :password => "TempPassword")

if Rails.env.development?
  User.create!(:first_name => "Test", :last_name => "Admin", :uin => 100000001, :user_type => :admin, :email => "admin@test.com", :password => "AdminPassword")
  User.create!(:first_name => "Test", :last_name => "Executive", :uin => 100000002, :user_type => :executive, :email => "exec@test.com", :password => "ExecPassword")
  User.create!(:first_name => "Test", :last_name => "Staff", :uin => 100000003, :user_type => :staff, :email => "staff@test.com", :password => "StaffPassword", :committee => pr_committee)
 
 #CR Committee
 User.create!(:first_name => "CR", :last_name => "Mentor", :uin => 100000007, :user_type => :staff, :email => "CRMentor@test.com", :password => "CRMentorPassword", :committee => campus_relations_committee)
 User.create!(:first_name => "CR", :last_name => "Freshman1", :uin => 100000008, :user_type => :base, :email => "CRFreshman1@test.com", :password => "CRFreshman1Password", :committee => campus_relations_committee)
 User.create!(:first_name => "CR", :last_name => "Freshman2", :uin => 100000009, :user_type => :base, :email => "CRFreshman2@test.com", :password => "CRFreshman2Password", :committee => campus_relations_committee)
 User.create!(:first_name => "CR", :last_name => "Freshman3", :uin => 100000010, :user_type => :base, :email => "CRFreshman3@test.com", :password => "CRFreshman3Password", :committee => campus_relations_committee)
  
 
  test_user1 = User.create!(:first_name => "PR", :last_name => "User", :uin => 100000004, :user_type => :base, :email => "user@test.com", :password => "UserPassword", :committee => pr_committee)
  test_user2 = User.create!(:first_name => "GB", :last_name => "User", :uin => 100000005, :user_type => :base, :email => "cool_user@test.com", :password => "UserPassword", :committee => give_back_committee)
  test_user3 = User.create!(:first_name => "Test", :last_name => "PendingUser", :uin => 100000006, :user_type => :base, :email => "pending@test.com", :password => "PendingPassword")


  test_event1 = Event.create!(:name => "Sample Fundriasing Event", :start_timestamp => DateTime.current, :end_timestamp => Date.tomorrow, :location => "HRBB 124", :committee => fundraising_committee, :point_value => 1,
                              :passcode => "1234")
  test_event2 = Event.create!(:name => "Campus Relations Event", :start_timestamp => DateTime.current, :end_timestamp => Date.tomorrow, :location => "HRBB 124", :committee => campus_relations_committee, :point_value => 1,
                              :passcode => "1234")
  test_event3 = Event.create!(:name => "Coomunity Outreach Event", :start_timestamp => DateTime.current, :end_timestamp => Date.tomorrow, :location => "HRBB 124", :committee => community_outreach_committee,
                              :point_value => 1, :passcode => "1234")

  AttendanceLog.create!(:user => test_user1, :event => test_event1, :passcode => "1234")
  AttendanceLog.create!(:user => test_user1, :event => test_event2, :passcode => "1234")
  AttendanceLog.create!(:user => test_user1, :event => test_event3, :passcode => "1234")

  AttendanceLog.create!(:user => test_user2, :event => test_event1, :passcode => "1234")
  AttendanceLog.create!(:user => test_user2, :event => test_event2, :passcode => "1234")
  AttendanceLog.create!(:user => test_user2, :event => test_event3, :passcode => "1234")
end
