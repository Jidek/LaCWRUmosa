class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end
  
  # def edit
  #   @user = User.find(params[:id])
  # end

  # def update
  #   @user = User.find(params[:id])
  #
  #   if @user.update_attributes(user_params)
  #     redirect_to user_path(@user)
  #   else
  #     render action: :edit
  #   end
  #
  # end

  private

  # def event_params
  #   params.require(:user).permit(:id, :nickname, :grad_year, :major)
  # end

end
