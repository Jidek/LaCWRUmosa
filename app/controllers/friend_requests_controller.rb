class FriendRequestsController < ApplicationController

  def index
    @FriendRequests = FriendRequest.where(to_user_id: session[:cas_user], acceptance_status: 0)
  end

  def accept
    request = FriendRequest.where(from_user_id: params[:from_user_id], to_user_id: params[:to_user_id]).first
    if request.present?
      request.acceptance_status = 1
      request.save
    end
    redirect_to user_path(params[:from_user_id])
  end

  def reject
    request = FriendRequest.where(from_user_id: params[:from_user_id], to_user_id: params[:to_user_id]).first
    if request.present?
      request.acceptance_status = 2
      request.save
    end
    redirect_to friend_requests_path
  end

end
