class RsvpsController < ApplicationController
  before_action :confirm_logged_in

  def new
    # takes a query parameter of eid from events#show
    # and populates a hidden form field in rsvp#new
    @rsvp = Rsvp.new(:event_id => params[:eid])
  end

  def create
    @rsvp = Rsvp.new(rsvp_params)
    @rsvp.user_id = current_user.id
    if @rsvp.save
      # Redirect the user to the event's page if the rsvp is saved correctly
      redirect_to events_path, :alert => 'RSVP logged'
    else
      # Otherwise, render rsvp#new with the appropriate errors
      render 'new'
    end
  end

  def edit
    # find RSVP log for current user
    @rsvp = Rsvp.where(:user_id => current_user.id, :event_id => params[:eid]).first
  end

  def update
    @rsvp = Rsvp.where(:user_id => current_user.id, :event_id => params[:rsvp][:event_id]).first
    if @rsvp.update(rsvp_params)
      # Redirect the user to the event's page if the rsvp is updated
      redirect_to events_path, :alert => 'RSVP updated'
    else
      # Otherwise, render rsvp#edit with the appropriate errors
      render 'edit'
    end
  end

  private

  # @return [ActionController::Parameters] This is a list of trusted parameters to pass to the rsvp model.
  def rsvp_params
    params.require(:rsvp).permit(:rsvp_option, :event_id)
  end
end
