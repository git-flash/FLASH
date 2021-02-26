class AttendanceCommitteeController < ApplicationController
  class CommitteePoints
    attr_accessor :committee, :social_points, :fundraising_points, :campus_relations_points, :pr_points, :community_outreach_points, :give_back_points
  end

  def index
    if user_signed_in? && current_user.check_executive?
      @committeeRows = [];

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
    else
      redirect_to root_path, alert: "You do not have permissions"
    end
  end

  def show
    if user_signed_in? && current_user.check_staff?
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
    else
      redirect_to root_path, alert: "You do not have permissions"
    end
  end
end

# ../attendance/committee/{id}  Shows points and logs for committee, only >exec, or >staff for committee
# ../attendance/committee       Shows points for all committees as index, only >exec
