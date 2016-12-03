class Location < ActiveRecord::Base
  belongs_to :indoor_location, optional: true
  has_many :ratings

  def score
    score = 0
    self.ratings.each{|rating| rating.rating? ? score += 1 : score -= 1}
    return score
  end

end
