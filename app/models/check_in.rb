class CheckIn < ActiveRecord::Base

  belongs_to :user, :class_name => "User", :foreign_key => "UserID"
  belongs_to :location, :class_name => "Location", :foreign_key => "LocationID"
end
