# MR
class AttendanceLogsController < ApplicationController
  before_action :confirm_logged_in

  def new
    # takes a query parameter of eid from events#show
    # and populates a hidden form field in attendance_logs#new
    @log = AttendanceLog.new(:event_id => params[:eid])
  end

  def create
    @log = AttendanceLog.new(attendance_log_params)
    @log.user_id = current_user.id
    if @log.save
      redirect_to events_path, :alert => 'Attendance logged.'
    else
      render 'new'
    end
  end

  private def attendance_log_params
    params.require(:attendance_log).permit(:passcode, :event_id)
  end
end
