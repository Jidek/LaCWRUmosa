class IndoorLocation < ActiveRecord::Base
  belongs_to :location

  def self.selectable_list
    IndoorLocation.all.map do |indoor_location|
      ["#{indoor_location.Building} Floor #{indoor_location.Floor} Room #{indoor_location.Room}", indoor_location.IndoorID]
    end
  end

end
