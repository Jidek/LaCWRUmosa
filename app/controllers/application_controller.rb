class ApplicationController < ActionController::Base
  before_action CASClient::Frameworks::Rails::Filter
  before_action :authenticate
  before_action :get_pending_entities
  protect_from_forgery with: :exception
  helper_method :params

  def authenticate
    if User.where(user_id: session[:cas_user]).blank?
      User.create(user_id: session[:cas_user])
    end
  end

  def get_pending_entities
    @pending_invitations = Invite.where(user_id: session[:cas_user], rsvp: Invite.rsvps[:no_response])
    @pending_friend_requests = FriendRequest.where(to_user_id: session[:cas_user], acceptance_status: FriendRequest.acceptance_statuses[:no_response])
  end
end
