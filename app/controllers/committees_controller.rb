#BE
class CommitteesController < ApplicationController
  before_action :set_committee, only: [:show, :edit, :update, :destroy]
  before_action :confirm_exec, only: [:new, :create, :update, :edit, :destroy]
  before_action :confirm_logged_in

  # Shows all committees to all logged in users
  def index
    @committees = Committee.all
  end

  # Shows a specific committee to logged in users
  def show; end

  # Creates a new committee, can only be done bby >execs
  def new
    @committee = new
  end

  # Creates a new committee, can only be done bby >execs
  def create
    @committee = Committee.new(committee_params)

    respond_to do |format|
      if @committee.save
        format.html { redirect_to committees_url, notice: "Committee successfully created" }
        format.json { render :show, status: :created, location: @committee }
      else
        format.html { render :new }
        format.json { render json: @committee.errors, status: :unprocessable_entity }
      end
    end
  end

  # Changes a committee, can only be done bby >execs
  def update
    respond_to do |format|
      if @committee.update(committee_params)
        format.html { redirect_to committees_url, notice: 'Committee was successfully updated.' }
        format.json { render :show, status: :ok, location: @committee }
      else
        format.html { render :edit }
        format.json { render json: @committee.errors, status: :unprocessable_entity }
      end
    end
  end

  # Changes a committee, can only be done bby >execs
  def edit; end

  # Deletes a committee, can only be done bby >execs
  def destroy
    @committee.destroy
    respond_to do |format|
      format.html { redirect_to committees_path, notice: 'Committee was successfully deleted' }
      format.json { head :no_content }
    end
  end

  # Sets the committee to the param
  private def set_committee
    @committee = Committee.find(params[:id])
  end

  # Gets the committee param
  private def committee_params
    params.require(:committee).permit(:name)
  end
end
