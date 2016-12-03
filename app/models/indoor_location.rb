class IndoorLocation < ActiveRecord::Base
  has_many :locations

  def self.selectable_list
    IndoorLocation.all.map do |indoor_location|
       ["#{indoor_location.building} floor #{indoor_location.floor} room #{indoor_location.room}", indoor_location.id]
    end
  end

end
