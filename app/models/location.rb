class Location < ActiveRecord::Base
  has_one :indoor_location, class_name: "IndoorLocation", foreign_key: "indoor_location_id"

end
