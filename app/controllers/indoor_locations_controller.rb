class IndoorLocationsController < ApplicationController

  def index
    @indoor_locations = IndoorLocation.all
  end

  def show
    @indoor_location = IndoorLocation.find(params[:id])
  end

  def new
    @indoor_location = IndoorLocation.new
  end

  def create
    @indoor_location = IndoorLocation.new(indoor_location_params)
    if @indoor_location.save
      redirect_to indoor_location_url(@indoor_location)
    else
      render action: :new
    end
  end

  def edit
    @indoor_location = IndoorLocation.find(params[:id])
  end

  def update
    @indoor_location = IndoorLocation.find(params[:id])
    if @indoor_location.update_attributes(indoor_location_params)
      redirect_to indoor_location_path(@indoor_location)
    else
      render action: :edit
    end
  end

  private

  def indoor_location_params
    params.require(:indoor_location).permit(:building, :room, :floor)
  end

end
