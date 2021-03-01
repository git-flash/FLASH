#BE
class CommitteesController < ApplicationController
  before_action :set_committee, only: [:show, :edit, :update, :destroy]
  before_action :confirm_exec, only: [:new, :create, :update, :edit, :destroy]

  def index
    @committees = Committee.all
  end

  def show; end

  def new
    @committee = new
  end

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

  def edit; end

  def destroy
    @committee.destroy
    respond_to do |format|
      format.html { redirect_to committees_path, notice: 'Committee was successfully deleted' }
      format.json { head :no_content }
    end
  end

  private def set_committee
    @committee = Committee.find(params[:id])
  end

  private def committee_params
    params.require(:committee).permit(:name)
  end
end
