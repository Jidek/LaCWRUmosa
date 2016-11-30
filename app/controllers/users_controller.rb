class UsersController < ApplicationController

  def feed
    @user = session[:cas_user]
  end

  def friends
    me = User.where(UserID: session[:cas_user]).first
    @friends = me.friends
  end

  def index
  end

  def edit
  end

end
