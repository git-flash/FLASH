#MR
class EventsController < ApplicationController
  before_action :confirm_logged_in
  skip_before_action :confirm_staff, :only => [:index, :show]

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
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if event.save
      redirect_to events_path, alert: 'Event Created'
    else
      render('new')
    end
  end

  def edit
    # Edit event if >staff
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to event_path(@event), alert 'Event Updated'
    else
      render('edit')
    end
  end

  def delete
    # Delete event if >staff
    @event = Event.find(params[:id])
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to event_path, alert: 'Event Deleted'
  end

  private

  def event_params
    params.reqire(:event).permit(:name, :start_timestamp, :end_timestamp, :location, :point_value, :passcode)
  end

end
