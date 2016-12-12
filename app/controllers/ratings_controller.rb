class RatingsController < ApplicationController

  def upvote
    Rating.transaction do
      @rating = Rating.where(user_id: session[:cas_user], location_id: params[:id]).first
      @rating = Rating.new(user_id: session[:cas_user], location_id: params[:id]) if @rating.blank?
      @rating.rating = 1
      @rating.save
    end
    redirect_to location_url(params[:id])
  end

  def downvote
    Rating.transaction do
      @rating = Rating.where(user_id: session[:cas_user], location_id: params[:id]).first
      @rating = Rating.new(user_id: session[:cas_user], location_id: params[:id]) if @rating.blank?
      @rating.rating = -1
      @rating.save
    end
    redirect_to location_url(params[:id])
  end

end
