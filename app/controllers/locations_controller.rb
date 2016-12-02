class LocationsController < ApplicationController

  def index
    @locations = Location.includes(:indoor_location).all
  end

  def new
    @location = Location.new
  end

end
