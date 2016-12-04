class LocationsController < ApplicationController

  def index
    search = []
    search_params = {}

    if params[:description].present? && params[:description][:filter].present?
      search << "description like :description"
      search_params.merge! description: "%#{params[:description][:filter]}%"
    end

    @locations = Location.includes(:indoor_location, :ratings).where(search.join(' AND '), search_params)
  end

  def show
    @location = Location.includes(:indoor_location, :ratings).find(params[:id])
    @rating = Rating.where(user_id: session[:cas_user], location_id: params[:id]).first
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    @location.creator_id = session[:cas_user]
    @location.creation_time = DateTime.now
    if @location.save
      redirect_to location_url(@location)
    else
      render action: :new
    end
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])
    if @location.update_attributes(location_params)
      redirect_to location_path(@location)
    else
      render action: :edit
    end
  end

  def check_in
    check_in = CheckIn.new(user_id: session[:cas_user], location_id: params[:id])
    check_in.save
    redirect_to location_url(params[:id])
  end

  private

  def location_params
    params.require(:location).permit(:description, :latitude, :longitude, :indoor_location_id)
  end

end
