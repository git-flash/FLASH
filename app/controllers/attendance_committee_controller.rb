class AttendanceCommitteeController < ApplicationController
  before_action :confirm_logged_in, only: [:index, :show]
  before_action only: [:index] do
    confirm_logged_in('Please Log In')
  end
  before_action :confirm_staff, only: [:index, :show]
  
  class CommitteePoints
    attr_accessor :committee, :social_points, :fundraising_points, :campus_relations_points, :pr_points, :community_outreach_points, :give_back_points
  end

  # Shows points for all committees as index, only >exec
  def index
    @committeeRows = []

    committeeList = Committee.all

    committeeList.each do |com|
      new_commitee = CommitteePoints.new
      new_commitee.committee = com

      # Add Point Values to New Committee Object
      new_commitee.social_points = com.points_of_type(Committee.find_by_name("Social"))
      new_commitee.fundraising_points = com.points_of_type(Committee.find_by_name("Fundraising"))
      new_commitee.campus_relations_points = com.points_of_type(Committee.find_by_name("Campus Relations"))
      new_commitee.pr_points = com.points_of_type(Committee.find_by_name("Public Relations"))
      new_commitee.community_outreach_points = com.points_of_type(Committee.find_by_name("Community Outreach"))
      new_commitee.give_back_points = com.points_of_type(Committee.find_by_name("Give Back"))

      @committeeRows.push new_commitee
    end
  end

  # Shows points and logs for committee, only >exec, or >staff for committee
  def show
    # If a staff user, ensure they can only access their committee
    if (!current_user.check_executive?) && (current_user.committee.id.to_i != params[:id].to_i)
      redirect_to root_path, alert: "You do not have permissions"
    end
    @committee = Committee.find(params[:id])
  end
end
