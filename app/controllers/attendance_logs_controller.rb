#MR
class AttendanceLogsController < ApplicationController
  before_action :confirm_logged_in

  # def index
  # end

  # def show
  # end

  def new
    # takes a query parameter of eid from events#show
    # and populates a hidden form field in attendance_logs#new
    @log = AttendanceLog.new(event_id: params[:eid])
  end

  def create
    @log = AttendanceLog.new(attendance_log_params)
    @log.user_id = current_user.id
    if @log.save
      redirect_to events_path, alert: 'Attendance logged.'
    else
      # redirect_to new_attendance_log_path(eid: @log.event_id), alert: "Couldn't log attendance."
      render 'new'
    end
  end

  # def delete
  # end

  private

  def attendance_log_params
    params.require(:attendance_log).permit(:passcode, :event_id)
  end

end

# ../attendance/user      ST
# ../attendance/committee CC
# ../attendance           MR

# ../attendance                 Shows all attendance >exec
# ../attendance/{id}            Shows specific attendance, >exec or >staff for specific committee, or specific user
# ../attendance/delete/{id}     >exec or >staff for specific committee or specific user
# ../attendance/new             >exec or specefic user
