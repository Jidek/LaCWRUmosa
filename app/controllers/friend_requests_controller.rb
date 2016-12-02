class FriendRequestsController < ApplicationController

  def index
    @FriendRequests = FriendRequest.where(to_user_id: session[:cas_user], acceptance_status: 0)
  end

end
