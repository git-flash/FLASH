#MR
class EventsController < ApplicationController
  before_action :confirm_logged_in, :only => [:show]
  before_action :only => [:index] do
    confirm_logged_in('Please Log In') unless user_signed_in?
  end
  before_action :confirm_staff, :only => [:new, :create, :edit, :update, :delete, :destroy]

  def index
    # Calendar/event view
    # Root path
    # Scope your query to the dates being shown:
    start_date = params.fetch(:start_date, Time.zone.today).to_date
    start_date = Time.zone.now.change(:year => start_date.year, :month => start_date.month, :day => start_date.day)
    @events = Event.month(start_date)
  end

  def show
    # View event details
    @event = Event.find(params[:id])
  end

  def new
    # Create event if >staff
    @event = Event.new(:point_value => 1)
  end

  def create
    @event = Event.new(event_params)
    @event.committee_id = current_user.committee_id unless current_user.check_executive?
    if @event.save
      # Redirect the user to the events page if the event is saved correctly
      redirect_to events_path, :alert => 'Event created.'
    else
      # Otherwise, render events#new with the appropriate errors
      render 'new'
    end
  end

  def edit
    # Edit event if >staff
    @event = Event.find(params[:id])
    confirm_event_staff(@event) unless current_user.check_executive?
  end

  def update
    @event = Event.find(params[:id])
    confirm_event_staff(@event) unless current_user.check_executive?
    if @event.update(event_params)
      # Redirect the user to the event's page if the event is updated correctly
      redirect_to event_path(@event), :alert => 'Event updated.'
    else
      # Otherwise, render events#edit with the appropriate errors
      render 'edit'
    end
  end

  def delete
    # Delete event if >staff
    @event = Event.find(params[:id])
    confirm_event_staff(@event) unless current_user.check_executive?
  end

  def destroy
    @event = Event.find(params[:id])
    confirm_event_staff(@event) unless current_user.check_executive?

    # destroy event
    @event.destroy
    redirect_to events_path, :alert => 'Event deleted'
  end

  private

  # @return [ActionController::Parameters] This is a list of trusted parameters to pass to the event model.
  #noinspection RubyYardReturnMatch
  def event_params
    if current_user.check_executive?
      params.require(:event).permit(:name, :committee_id, :start_timestamp, :end_timestamp, :location, :point_value, :passcode)
    else
      params.require(:event).permit(:name, :start_timestamp, :end_timestamp, :location, :point_value, :passcode)
    end
  end

end
