class FriendRequest < ActiveRecord::Base
  self.primary_keys = :from_user_id, :to_user_id

  belongs_to :from, :class_name => "User", :foreign_key => "from_user_id"
  belongs_to :to, :class_name => "User", :foreign_key => "to_user_id"

  enum acceptance_status: {no_response: 0, accepted: 1, rejected: 2}
end
