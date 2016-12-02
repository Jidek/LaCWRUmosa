class InvitesController < ApplicationController

  def index
    @Invites = Invite.where(UserID: session[:cas_user])
  end

end
