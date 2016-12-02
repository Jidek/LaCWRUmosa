class FriendRequest < ActiveRecord::Base

  belongs_to :from, :class_name => "User", :foreign_key => "FromUserID"
  belongs_to :to, :class_name => "User", :foreign_key => "ToUserID"
end
