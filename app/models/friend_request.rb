class FriendRequest < ActiveRecord::Base

  belongs_to :from, :class_name => "User", :foreign_key => "UserID"
  belongs_to :to, :class_name => "User", :foreign_key => "UserID"
end
