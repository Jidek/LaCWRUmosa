class Invite < ActiveRecord::Base

  belongs_to :event, :class_name => "Event", :foreign_key => "EventID"
  belongs_to :user, :class_name => "User", :foreign_key => "UserID"
end
