class CheckInsController < ApplicationController

  def index
    @CheckIns = CheckIn.where(user_id: User.where(user_id: session[:cas_user]).first.friends)
  end

  def new
    #@CheckIns = CheckIn
  end

end
