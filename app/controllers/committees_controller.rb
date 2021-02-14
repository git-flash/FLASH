#BE
class CommitteesController < ApplicationController
  before_action :set_committee, only: [:show, :edit, :update, :destroy]

  def index
    @committees = Committee.all
    console
  end

  def show; end

  def new
    if user_signed_in? && current_user.check_executive?
      @committee = new
    else
      redirect_to root_path, alert: "You do not have permissions"
    end
  end

  def create
    if user_signed_in? && current_user.check_executive?
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
    else
      redirect_to root_path, alert: "You do not have permissions"
    end
  end

  def update
    if user_signed_in? && current_user.check_executive?
      respond_to do |format|
        if @committee.update(committee_params)
          format.html { redirect_to committees_url, notice: 'Committee was successfully updated.' }
          format.json { render :show, status: :ok, location: @committee }
        else
          format.html { render :edit }
          format.json { render json: @committee.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path, alert: "You do not have permissions"
    end
  end

  def edit
    unless user_signed_in? && current_user.check_executive?
      redirect_to root_path, alert: "You do not have permissions"
    end
  end

  def destroy
    if user_signed_in? && current_user.check_executive?
      @committee.destroy
      respond_to do |format|
        format.html { redirect_to committees_path, notice: 'Committee was successfully deleted' }
        format.json { head :no_content }
      end
    else
      redirect_to root_path, alert: "You do not have permissions"
    end
  end

  private def set_committee
    @committee = Committee.find(params[:id])
  end

  private def committee_params
    params.require(:committee).permit(:name)
  end
end
