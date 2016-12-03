class Rating < ActiveRecord::Base
  self.primary_keys = :user_id, :location_id
  belongs_to :location
  belongs_to :user

  def positive?
    self.rating == 1
  end

  def negative?
    self.rating == 0
  end

end
