class InvitesController < ApplicationController

  def index
    @Invites = Invite.where(user_id: session[:cas_user])
  end

  def accept
    invite = Invite.where(user_id: params[:user_id], event_id: params[:event_id]).first
    if invite.present?
      invite.rsvp = "accepted"
      invite.save
    end
    redirect_to :back
  end

 def decline
    invite = Invite.where(user_id: params[:user_id], event_id: params[:event_id]).first
    if invite.present?
      invite.rsvp = "rejected"
      invite.save
    end
    redirect_to :back
  end

end
