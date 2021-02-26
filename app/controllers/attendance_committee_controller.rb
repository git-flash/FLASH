class AttendanceCommitteeController < ApplicationController
  before_action :confirm_logged_in, :only => %i[index show]
  before_action :only => [:index] do
    confirm_logged_in('Please Log In')
  end
  before_action :confirm_staff, :only => %i[index show]

  class CommitteePoints
    attr_accessor :committee, :social_points, :fundraising_points, :campus_relations_points, :pr_points, :community_outreach_points, :give_back_points
  end

  # Shows points for all committees as index, only >exec
  def index
    @committee_rows = []

    committee_list = Committee.all

    committee_list.each do |com|
      new_committee = CommitteePoints.new
      new_committee.committee = com

      # Add Point Values to New Committee Object
      new_committee.social_points = com.points_of_type(Committee.find_by(:name => "Social"))
      new_committee.fundraising_points = com.points_of_type(Committee.find_by(:name => "Fundraising"))
      new_committee.campus_relations_points = com.points_of_type(Committee.find_by(:name => "Campus Relations"))
      new_committee.pr_points = com.points_of_type(Committee.find_by(:name => "Public Relations"))
      new_committee.community_outreach_points = com.points_of_type(Committee.find_by(:name => "Community Outreach"))
      new_committee.give_back_points = com.points_of_type(Committee.find_by(:name => "Give Back"))

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
  end
end
