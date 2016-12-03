class RatingsController < ApplicationController

  def upvote
    @rating = Rating.find([session[:cas_user], params[:id]])
    @rating = Rating.new(user_id: session[:cas_user], location_id: params[:id]) if @rating.blank?
    @rating.rating = 1
    @rating.save
    redirect_to location_url(params[:id])
  end

  def downvote
    @rating = Rating.find([session[:cas_user], params[:id]])
    @rating = Rating.new(user_id: session[:cas_user], location_id: params[:id]) if @rating.blank?
    @rating.rating = 0
    @rating.save
    redirect_to location_url(params[:id])
  end

end
