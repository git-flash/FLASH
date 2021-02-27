class AttendanceCommitteeController < ApplicationController
  before_action :confirm_logged_in, only: [:index, :show]
  before_action only: [:index] do
    confirm_logged_in('Please Log In')
  end
  before_action :confirm_staff, only: [:show]
  before_action :confirm_exec, only: [:index]
  
  class CommitteePoints
    attr_accessor :committee, :social_points, :fundraising_points, :campus_relations_points, :pr_points, :community_outreach_points, :give_back_points
  end

  # Shows points for all committees as index, only >exec
  def index
    @committee_rows = []

    committeeList = Committee.all

    committeeList.each do |com|
      new_committee = CommitteePoints.new
      new_committee.committee = com

      # Add Point Values to New Committee Object
      new_committee.social_points = com.points_of_type(Committee.find_by_name("Social"))
      new_committee.fundraising_points = com.points_of_type(Committee.find_by_name("Fundraising"))
      new_committee.campus_relations_points = com.points_of_type(Committee.find_by_name("Campus Relations"))
      new_committee.pr_points = com.points_of_type(Committee.find_by_name("Public Relations"))
      new_committee.community_outreach_points = com.points_of_type(Committee.find_by_name("Community Outreach"))
      new_committee.give_back_points = com.points_of_type(Committee.find_by_name("Give Back"))

      @committee_rows.push new_committee
    end
  end

  # Shows points and logs for committee, only >exec, or >staff for committee
  def show
    # If a staff user, ensure they can only access their committee
    if (!current_user.check_executive?) && (current_user.committee.id.to_i != params[:id].to_i)
      redirect_to root_path, alert: "You do not have permissions"
    end

    @committee = Committee.find(params[:id])
    @committee_points = 0

    unless @committee.points_of_type(Committee.find_by_name("Social")).nil?
      @committee_points += @committee.points_of_type(Committee.find_by_name("Social"))
    end

    unless @committee.points_of_type(Committee.find_by_name("Fundraising")).nil?
      @committee_points += @committee.points_of_type(Committee.find_by_name("Fundraising"))
    end

    unless @committee.points_of_type(Committee.find_by_name("Campus Relations")).nil?
      @committee_points += @committee.points_of_type(Committee.find_by_name("Campus Relations"))
    end

    unless @committee.points_of_type(Committee.find_by_name("Public Relations")).nil?
      @committee_points += @committee.points_of_type(Committee.find_by_name("Public Relations"))
    end

    unless @committee.points_of_type(Committee.find_by_name("Community Outreach")).nil?
      @committee_points += @committee.points_of_type(Committee.find_by_name("Community Outreach"))
    end

    unless @committee.points_of_type(Committee.find_by_name("Give Back")).nil?
      @committee_points += @committee.points_of_type(Committee.find_by_name("Give Back"))
    end

    @committee = Committee.find(params[:id])
  end
end
