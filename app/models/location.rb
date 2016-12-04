class Location < ActiveRecord::Base
  belongs_to :indoor_location, optional: true
  has_many :ratings

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode  # auto-fetch address

  def score
    score = 0
    self.ratings.each{|rating| rating.rating? ? score += 1 : score -= 1}
    return score
  end

  def self.selectable_list
    Location.all.map do |location|
       ["#{location.description} (#{location.latitude}, #{location.longitude})", location.id]
    end
  end

end
