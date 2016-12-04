class EventsController < ApplicationController

  def index
    search = []
    search_params = {}

    if params[:time].present? && params[:time][:filter].present?
      search << "time < :time"
      search_params.merge! time: "#{params[:time][:filter].to_f.hours.from_now}"
      search << "time > :time_now"
      search_params.merge! time_now: "#{Time.now}"
    end

    if params[:location].present? && params[:location][:filter].present?
      search << "description like :description"
      search_params.merge! description: "%#{params[:location][:filter]}%"
    end

    @events = Event.joins(:location).where(search.join(' AND '), search_params)
  end

  def show
    @event = Event.find(params[:id])
    @invites = Invite.where(event_id: params[:id], rsvp: Invite.rsvps[:accepted])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update_attributes(event_params)
      redirect_to event_path(@event)
    else
      render action: :edit
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to event_url(@event)
    else
      render action: :new
    end
  end

  def send_event_invite
    event = params[:id]
    rsvp = Invite.rsvps[:no_response]
    user = params[:case_id]

    if Invite.where(user_id: user, event_id: event).blank?
      request = Invite.new(user_id: user, event_id: event, rsvp: rsvp)
      request.save
    end
    redirect_to :back
  end

  private

  def event_params
    params.require(:event).permit(:id, :time, :location_id)
  end

end
