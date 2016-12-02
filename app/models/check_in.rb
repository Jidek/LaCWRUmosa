class CheckIn < ActiveRecord::Base

  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  belongs_to :location, :class_name => "Location", :foreign_key => "location_id"
end
