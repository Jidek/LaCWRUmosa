class User < ActiveRecord::Base
  has_many :ratings

  def friends
    User.where(user_id: get_friend_ids(self.user_id))
  end

  def name
    self.nickname || self.user_id
  end

  private

  def get_friend_ids(user_id)
    FriendRequest.where(from_user_id: user_id, acceptance_status: FriendRequest.acceptance_statuses[:accepted]).pluck(:to_user_id) +
    FriendRequest.where(to_user_id: user_id, acceptance_status: FriendRequest.acceptance_statuses[:accepted]).pluck(:from_user_id)
  end
end
