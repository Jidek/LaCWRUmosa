class CheckInsController < ApplicationController

  def index
    @CheckIns = CheckIn.all
  end

end
