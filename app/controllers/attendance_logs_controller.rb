# frozen_string_literal: true

# MR
class AttendanceLogsController < ApplicationController
  before_action :confirm_logged_in
  before_action :confirm_freshman

  def new
    # takes a query parameter of eid from events#show
    # and populates a hidden form field in attendance_logs#new
    @log = AttendanceLog.new(event_id: params[:eid])
  end

  def create
    @log = AttendanceLog.new(attendance_log_params)
    @log.user_id = current_user.id
    if @log.save
      # Redirect the user to the events page if the log is saved correctly
      redirect_to events_path, alert: 'Attendance logged.'
    else
      # Otherwise, render attendance_logs#new with the appropriate errors
      render 'new'
    end
  end

  private

  # @return [ActionController::Parameters] This is a list of trusted parameters to pass to the attendance log model.
  def attendance_log_params
    params.require(:attendance_log).permit(:passcode, :event_id)
  end
end
