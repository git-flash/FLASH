# frozen_string_literal: true

# BE
# rubocop:disable Metrics/ClassLength
class CommitteesController < ApplicationController
  before_action :set_committee, only: %i[show edit update destroy]
  before_action :confirm_exec, only: %i[new create update edit destroy]
  before_action :confirm_logged_in

  class CommitteePoints
    attr_accessor :committee_name, :points
  end

  class AttendanceCommitteePoints
    attr_accessor :committee, :committee_points_list, :total_points
  end

  class UserAttendancePoints
    attr_accessor :user, :user_points_list, :total_points
  end

  # Shows all committees to all logged in users
  def index
    @committees = Committee.all.order(:name)

    @committee_rows = []
    committee_list = []

    if current_user.check_executive?
      committee_list = Committee.all
    else
      committee_list.push Committee.find_by(name: current_user.committee.name)
    end

    # For each committee, create an object to contain points held in each subcommittee
    committee_list.each do |com|
      new_committee = AttendanceCommitteePoints.new
      new_committee.committee = com
      committee_points_list = []
      total_points = 0

      # Loop through each committee, and determine how many points com has in each committee
      committee_list.each do |com_points|
        committee_points_entry = CommitteePoints.new

        committee_points_entry.committee_name = com_points.name
        committee_points_entry.points = com.points_of_type(Committee.find_by(name: com_points.name))
        total_points += committee_points_entry.points

        committee_points_list.push committee_points_entry
      end

      new_committee.committee_points_list = committee_points_list
      new_committee.total_points = total_points

      # Add Point Values to New Committee Object
      @committee_rows.push new_committee
    end
  end

  # Shows a specific committee to logged in users
  def show
    # If a staff user, ensure they can only access their committee
    if !current_user.check_executive? && (current_user.committee.id.to_i != params[:id].to_i)
      redirect_to root_path,
                  alert: 'You do not have permissions'
    end

    @committee = Committee.find(params[:id])
    @committee_points_row = AttendanceCommitteePoints.new
    @committee_points_row.committee = @committee
    committee_points_list = []
    total_points = 0

    # Add Point Values to committee points object
    # Loop through each committee, and determine how many points com has in each committee
    Committee.all.order(:name).each do |com_points|
      committee_points_entry = CommitteePoints.new

      committee_points_entry.committee_name = com_points.name
      committee_points_entry.points = @committee.points_of_type(com_points)

      total_points += committee_points_entry.points

      committee_points_list.push committee_points_entry
    end

    @committee_points_row.committee_points_list = committee_points_list
    @committee_points_row.total_points = total_points

    @user_rows = []

    @committee.users.base.each do |com_user|
      new_user_row = UserAttendancePoints.new
      new_user_row.user = com_user
      user_total_points = 0
      user_points_list = []

      Committee.all.order(:name).each do |com_points|
        user_points_entry = CommitteePoints.new

        user_points_entry.committee_name = com_points.name
        user_points_entry.points = com_user.points_for_committee(com_points)

        user_total_points += user_points_entry.points

        user_points_list.push user_points_entry
      end

      new_user_row.user_points_list = user_points_list
      new_user_row.total_points = user_total_points

      # Add Point Values to New Committee Object
      @user_rows.push new_user_row
    end
  end

  # Creates a new committee, can only be done bby >execs
  def new
    @committee = Committee.new
  end

  # Creates a new committee, can only be done bby >execs
  def create
    @committee = Committee.new(committee_params)

    respond_to do |format|
      if @committee.save
        format.html { redirect_to committees_url, notice: 'Committee successfully created' }
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
# rubocop:enable Metrics/ClassLength
