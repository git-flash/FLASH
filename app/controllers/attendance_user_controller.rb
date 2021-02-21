#ST
class AttendanceUserController < ApplicationController

    def index
        if user_signed_in?
            @userRow = {};

            User.freshman.each do |usr|
                freshman = {}
            
                Committee.all.each do |committee|
                    freshman[committee] = User.points_for_committee(usr, committee)[0].total_points
                end
                @userRow[usr] = freshman
            end
        else
            redirect_to root_path, alert: "Please sign in first"
        end
    end 

    def show
        if user_signed_in?
            @user = User.find(params[:id])
            @userAttendanceLogs = AttendanceLog.user_log(params[:id])
        else
            redirect_to root_path, alert: "Please sign in first"
        end
    end
end

# ../attendance/user/{id}       Shows Points and logs for specific user, only actual user or >staff
# ../attendance/user            Shows points for all users as index, only >staff for user associated with comittee, or >exec
