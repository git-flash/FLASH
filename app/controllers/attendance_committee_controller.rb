#CC
class AttendanceCommitteeController < ApplicationController
    def show
        puts AttendanceLog.committee_log(params[:id]).inspect
        @committeeAttendanceLogs = AttendanceLog.committee_log(params[:id])
    end
    
    def index
        # puts Committee.committee_points.inspect
    end
end

# ../attendance/committee/{id}  Shows points and logs for committee, only >exec, or >staff for committee
# ../attendance/committee       Shows points for all committees as index, only >exec
