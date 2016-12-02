class FriendRequestsController < ApplicationController

  def index
    @FriendRequests = FriendRequest.where(ToUserID: session[:cas_user], AcceptanceStatus: 0)
  end

end
