# HG
class UsersController < ApplicationController
  # this before action sets the capabilities of the user
  before_action :set_user, :only => %i[show edit update destroy soft_delete]

  # this before action confirms the user logged in is an executive member or higher
  before_action :confirm_exec

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  # if the user being shown has a committee then this redirects to the current members page
  # otherwise they will be sent to the pending members page
  # this is just a workaround to prevent this show method from being used without
  # removing its potential future use
  def show
    if @user.committee
      redirect_to users_path
    else
      redirect_to users_pending_path  
    end
  end
  

  # GET /users/new
  # redirect people to the events page if they are trying
  def new
    redirect_to root_path
  end

  # GET /users/1/edit
  def edit; end

  # POST /users or /users.json
  def create; end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      # if the user enters some changes then apply those updates
      if @user.update(user_params)
        format.html { redirect_to @user, :notice => "user was successfully updated." }
        format.json { render :show, :status => :ok, :location => @user }
      else
        format.html { render :edit, :status => :unprocessable_entity }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Removes from 'Current Members' and puts in 'Pending Members'
  def soft_delete
    @user = User.find(params[:id])
    userName = @user.first_name + " " + @user.last_name
      
    @user.update(:committee_id => nil, :user_type => :base )
    
    respond_to do |format|
      if(@user.committee_id == nil)
        format.html { redirect_to users_url, :notice => userName + " was successfully removed from current members and was sent back to pending members with default values (Base member with TBD Committee)." }
        format.json { head :no_content }
      end
    end 
      
 
  end



  # DELETE /users/1 or /users/1.json
  def destroy
    # userName contains currently selected member's first name and last name
    userName = @user.first_name + " " + @user.last_name
    @user.delete
    respond_to do |format|
      # this check redirects to the current member or pending member page based on whichever page called destroy
      if @pendingCheck
        format.html { redirect_to users_pending_url, :notice => userName + " was successfully annihilated." }
      else
        format.html { redirect_to users_url, :notice => userName + " was successfully annihilated." }
      end
      format.json { head :no_content }
    end
  end

  def pending
    @users = User.all
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :uin, :user_type, :committee_id)
  end

end

# ../users              Shows a list of users, >exec
# ../users/{id}         Edit user committee, >exec
# ../users/delete/{id}  Delete specific user, >exec
# ../users/admin/{id}   Edit user role, >admin
