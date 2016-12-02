class User < ActiveRecord::Base

  def friends
    User.where(user_id: get_friend_ids(self.user_id))
  end

  private

  def get_friend_ids(user_id)
    FriendRequest.where(from_user_id: user_id, acceptance_status: 1).select(:to_user_id) +
    FriendRequest.where(to_user_id: user_id, acceptance_status: 1).select(:from_user_id)
  end
end
