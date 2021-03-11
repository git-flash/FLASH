class AttendanceCommitteeController < ApplicationController
  before_action :confirm_logged_in, :only => %i[index show]
  before_action :only => [:index] do
    confirm_logged_in('Please Log In')
  end
  before_action :confirm_staff, :only => [:show]
  before_action :confirm_exec, :only => [:index]

  class CommitteePoints
    attr_accessor :committee_name, :points
  end

  class AttendanceCommitteePoints
    attr_accessor :committee, :committee_points_list, :total_points
  end

  # Shows points for all committees as index, only >exec
  def index
    @committee_rows = []

    committee_list = Committee.all

    # For each committee, create an object to contain points held in each subcommittee
    committee_list.each do |com|
      new_committee = AttendanceCommitteePoints.new
      new_committee.committee = com
      committee_points_list = [];
      total_points = 0;

      # Loop through each committee, and determine how many points com has in each committee
      committee_list.each do |com_points|
        committee_points_entry = CommitteePoints.new

        committee_points_entry.committee_name = com_points.name
        committee_points_entry.points = com.points_of_type(Committee.find_by(:name => com_points.name))

        total_points += committee_points_entry.points;

        committee_points_list.push committee_points_entry
      end
      
      new_committee.committee_points_list = committee_points_list
      new_committee.total_points = total_points
      
      # Add Point Values to New Committee Object
      @committee_rows.push new_committee
    end
  end

  # Shows points and logs for committee, only >exec, or >staff for committee
  def show
    # If a staff user, ensure they can only access their committee
    if (!current_user.check_executive?) && (current_user.committee.id.to_i != params[:id].to_i)
      redirect_to root_path, :alert => "You do not have permissions"
    end

    @committee = Committee.find(params[:id])
    @committee_points_row = AttendanceCommitteePoints.new
    @committee_points_row.committee = @committee
    committee_points_list = []
    total_points = 0

    # Add Point Values to committee points object
    # Loop through each committee, and determine how many points com has in each committee
    Committee.all.each do |com_points|
      committee_points_entry = CommitteePoints.new

      committee_points_entry.committee_name = com_points.name
      committee_points_entry.points = @committee.points_of_type(Committee.find_by(:name => com_points.name))

      total_points += committee_points_entry.points;

      committee_points_list.push committee_points_entry
    end

    @committee_points_row.committee_points_list = committee_points_list
    @committee_points_row.total_points = total_points
  end
end
