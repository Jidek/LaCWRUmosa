class Location < ActiveRecord::Base
  has_one :indoor_location, foreign_key: "IndoorID"

end
