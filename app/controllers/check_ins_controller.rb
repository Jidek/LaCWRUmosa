class CheckInsController < ApplicationController

  def index
    @CheckIns = CheckIn.all
  end

  def new
    #@CheckIns = CheckIn
  end

end
