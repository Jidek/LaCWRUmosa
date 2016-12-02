class IndoorLocation < ActiveRecord::Base
  has_many :location, foreign_key: "indoor_location_id"

  def self.selectable_list
    IndoorLocation.all.map do |indoor_location|
      ["#{indoor_location.building} floor #{indoor_location.floor} room #{indoor_location.room}", indoor_location.indoor_location_id]
    end
  end

end
