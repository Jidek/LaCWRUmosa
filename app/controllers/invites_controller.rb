class InvitesController < ApplicationController

  def index
    @Invites = Invite.where(user_id: session[:cas_user])
  end

end
