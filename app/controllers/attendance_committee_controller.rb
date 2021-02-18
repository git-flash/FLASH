#CC
class AttendanceCommitteeController < ApplicationController
    class CommitteePoints
        attr_accessor :committee, :social_points, :fundraising_points, :campus_relations_points, :pr_points, :community_outreach_points, :give_back_points
      end

    def show
        @committee = Committee.find(params[:id])
        @committeeAttendanceLogs = AttendanceLog.committee_log(params[:id])
    end
    
    def index
        @committeeRows = [];

        committeeList = Committee.all

        committeeList.each do |com|
            new_commitee = CommitteePoints.new
            new_commitee.committee = com

            new_commitee.social_points = Committee.social_points(com.id)[0].total_points
            new_commitee.fundraising_points = Committee.fundraising_points(com.id)[0].total_points
            new_commitee.campus_relations_points = Committee.campus_relations_points(com.id)[0].total_points
            new_commitee.pr_points = Committee.pr_points(com.id)[0].total_points
            new_commitee.community_outreach_points = Committee.community_outreach_points(com.id)[0].total_points
            new_commitee.give_back_points = Committee.give_back_points(com.id)[0].total_points

            @committeeRows.push new_commitee
        end
        
    end
end

# ../attendance/committee/{id}  Shows points and logs for committee, only >exec, or >staff for committee
# ../attendance/committee       Shows points for all committees as index, only >exec
