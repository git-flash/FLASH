#ST
class AttendanceUserController < ApplicationController
  before_action :confirm_logged_in

  def index; end

  def show
    @user = User.find(params[:id])
  end
end

# ../attendance/user/{id}       Shows Points and logs for specific user, only actual user or >staff
# ../attendance/user            Shows points for all users as index, only >staff for user associated with comittee, or >exec
