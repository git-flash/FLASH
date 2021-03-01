#HG
class UsersController < ApplicationController
    before_action :set_user, only: %i[ show edit update destroy ]
    before_action :confirm_exec

    # GET /users or /users.json
    def index
      @users = User.all
    end
  
    # GET /users/1 or /users/1.json
    def show
      if (@user.committee)
        redirect_to users_path
      else
        redirect_to users_pending_path
      end
    end
  
    # GET /users/new
    def new
      redirect_to root_path
      @user = User.new
    end
  
    # GET /users/1/edit
    def edit
    end
  
    # POST /users or /users.json
    def create
      @user = User.new(user_params)
  
      respond_to do |format|
        if @user.save
          format.html { redirect_to @user, notice: "user was successfully created." }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /users/1 or /users/1.json
    def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to @user, notice: "user was successfully updated." }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /users/1 or /users/1.json
    def destroy
      userName = @user.first_name + " " + @user.last_name
      @user.destroy
      respond_to do |format|
        if (@pendingCheck)
          format.html { redirect_to users_pending_url, notice: userName + " was successfully annihilated." }
        else
          format.html { redirect_to users_url, notice: userName + " was successfully annihilated." }
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
