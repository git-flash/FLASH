#MR
class AttendanceLogsController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def delete
  end
end

# ../attendance/user      ST
# ../attendance/committee CC
# ../attendance           MR

# ../attendance                 Shows all attendance >exec
# ../attendance/{id}            Shows specific attendance, >exec or >staff for specific committee, or specific user
# ../attendance/delete/{id}     >exec or >staff for specific committee or specific user
# ../attendance/new             >exec or specefic user
