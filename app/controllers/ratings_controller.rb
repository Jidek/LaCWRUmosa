class RatingsController < ApplicationController

  def upvote
    @rating = Rating.where(user_id: session[:cas_user], location_id: params[:id]).first
    @rating = Rating.new(user_id: session[:cas_user], location_id: params[:id]) if @rating.blank?
    @rating.rating = 1
    @rating.save
    redirect_to location_url(params[:id])
  end

  def downvote
    @rating = Rating.where(user_id: session[:cas_user], location_id: params[:id]).first
    @rating = Rating.new(user_id: session[:cas_user], location_id: params[:id]) if @rating.blank?
    @rating.rating = -1
    @rating.save
    redirect_to location_url(params[:id])
  end

end
