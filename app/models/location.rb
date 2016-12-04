class Location < ActiveRecord::Base
  belongs_to :indoor_location, optional: true
  has_many :ratings

  def score
    self.ratings.pluck(:rating).sum
  end

  def self.selectable_list
    Location.all.map do |location|
       ["#{location.description} (#{location.latitude}, #{location.longitude})", location.id]
    end
  end

end
