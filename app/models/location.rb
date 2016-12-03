class Location < ActiveRecord::Base
  belongs_to :indoor_location, optional: true
  
end
