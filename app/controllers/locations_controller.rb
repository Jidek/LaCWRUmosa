class LocationsController < ApplicationController

  def index
    search = []
    search_params = {}
    indoor_search = false

    if params[:description].present? && params[:description][:filter].present?
      search << "description like :description"
      search_params.merge! description: "%#{params[:description][:filter]}%"
    end

    if params[:building].present? && params[:building][:filter].present?
      search << "building like :building"
      search_params.merge! building: "%#{params[:building][:filter]}%"
      indoor_search = true
    end

    if params[:floor].present? && params[:floor][:filter].present?
      search << "floor like :floor"
      search_params.merge! floor: "%#{params[:floor][:filter]}%"
      indoor_search = true
    end

    if params[:room].present? && params[:room][:filter].present?
      search << "room like :room"
      search_params.merge! room: "%#{params[:room][:filter]}%"
      indoor_search = true
    end

    if indoor_search
      @locations = Location.joins(:indoor_location).includes(:ratings).where(search.join(' AND '), search_params)
    else
      @locations = Location.includes(:ratings).where(search.join(' AND '), search_params)
    end
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
    check_in = CheckIn.new(user_id: session[:cas_user], location_id: params[:id], time: Time.now)
    check_in.save
    redirect_to location_url(params[:id])
  end

  def near_me
    @latitude = params[:latitude].to_f
    @longitude = params[:longitude].to_f

    if @latitude.present? and @longitude.present?
      point = [@latitude, @longitude]
      @locations = Location.near(point, 500, order: false).to_a.sort.reverse
    end
  end

  private

  def location_params
    params.require(:location).permit(:description, :latitude, :longitude, :indoor_location_id)
  end

end
