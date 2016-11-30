class User < ActiveRecord::Base

  def friends
    User.where(UserID: get_friend_ids(self.UserID))
  end

  private

  def get_friend_ids(user_id)
    FriendRequest.where(FromUserID: user_id, AcceptanceStatus: 1).select(:ToUserID) +
    FriendRequest.where(ToUserID: user_id, AcceptanceStatus: 1).select(:FromUserID)
  end
end
