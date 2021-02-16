#MR
class EventsController < ApplicationController
  before_action :confirm_logged_in, only: [:index, :show]
  before_action :confirm_staff, only: [:new, :create, :edit, :update, :delete, :destroy]

  def index
    # Calendar/event view
    # Root path
    @events = Event.order('start_timestamp ASC')
  end

  def show
    # View event details
    @event = Event.find(params[:id])
  end

  def new
    # Create event if >staff
    @event = Event.new(point_value: 1)
  end

  def create
    @event = Event.new(event_params)
    @event.committee_id = current_user.committee_id
    if @event.save
      redirect_to events_path, alert: 'Event created.'
    else
      redirect_to new_event_path, alert: "Couldn't create event."
    end
  end

  def edit
    # Edit event if >staff
    @event = Event.find(params[:id])
    confirm_event_staff(@event)
  end

  def update
    @event = Event.find(params[:id])
    confirm_event_staff(@event)
    if @event.update(event_params)
      redirect_to event_path(@event), alert: 'Event updated.'
    else
      redirect_to edit_event_path(@event), alert: "Couldn't update event."
    end
  end

  def delete
    # Delete event if >staff
    @event = Event.find(params[:id])
    confirm_event_staff(@event)
  end

  def destroy
    @event = Event.find(params[:id])
    confirm_event_staff(@event)
    @event.destroy
    redirect_to events_path, alert: 'Event deleted'
  end

  private

  def event_params
    params.require(:event).permit(:name, :start_timestamp, :end_timestamp, :location, :point_value, :passcode)
  end

end
