class AttendanceCommitteeController < ApplicationController
    before_action :confirm_logged_in, only: [:index, :show]
    before_action only: [:index] do
      confirm_logged_in('Please Log In')
    end
    before_action :confirm_staff, only: [:index, :show]

    class CommitteePoints
        attr_accessor :committee, :social_points, :fundraising_points, :campus_relations_points, :pr_points, :community_outreach_points, :give_back_points
      end

    def index
        @committee_rows = [];

        committee_list = Committee.all

        committee_list.each do |com|
            new_committee = CommitteePoints.new
            new_committee.committee = com

            # Add Point Values to New Committee Object
            new_committee.social_points = Committee.point_total(com.id, "social")[0].total_points
            new_committee.fundraising_points = Committee.point_total(com.id, "fundraising")[0].total_points
            new_committee.campus_relations_points = Committee.point_total(com.id, "campus_relations")[0].total_points
            new_committee.pr_points = Committee.point_total(com.id, "pr")[0].total_points
            new_committee.community_outreach_points = Committee.point_total(com.id, "community_outreach")[0].total_points
            new_committee.give_back_points = Committee.point_total(com.id, "give_back")[0].total_points

            @committee_rows.push new_committee
        end
    end

    def show
        # If a staff user, ensure they can only access their committee
        if (!current_user.check_executive?) && (current_user.committee.id.to_i != params[:id].to_i)
            redirect_to root_path, alert: "You do not have permissions"
        end

        @committee = Committee.find(params[:id])
        @committee_attendance_logs = AttendanceLog.committee_log(params[:id])
    end
end

# ../attendance/committee/{id}  Shows points and logs for committee, only >exec, or >staff for committee
# ../attendance/committee       Shows points for all committees as index, only >exec
