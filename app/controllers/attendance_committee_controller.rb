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
                new_commitee.social_points = Committee.point_total(com.id, "social")[0].total_points
                new_commitee.fundraising_points = Committee.point_total(com.id, "fundraising")[0].total_points
                new_commitee.campus_relations_points = Committee.point_total(com.id, "campus_relations")[0].total_points
                new_commitee.pr_points = Committee.point_total(com.id, "pr")[0].total_points
                new_commitee.community_outreach_points = Committee.point_total(com.id, "community_outreach")[0].total_points
                new_commitee.give_back_points = Committee.point_total(com.id, "give_back")[0].total_points

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
            @committeeAttendanceLogs = AttendanceLog.committee_log(params[:id])
        else
            redirect_to root_path, alert: "You do not have permissions"
        end
    end
end

# ../attendance/committee/{id}  Shows points and logs for committee, only >exec, or >staff for committee
# ../attendance/committee       Shows points for all committees as index, only >exec
