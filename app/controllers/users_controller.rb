class UsersController < ApplicationController

  def feed
    @user = session[:cas_user]
  end

  def friends
    me = User.where(user_id: session[:cas_user]).first
    @friends = me.friends
  end

  def index

    search = []
    search_params = {}

    if params[:user_id].present? && params[:user_id][:filter].present?
      search << "user_id like :user_id"
      search_params.merge! user_id: "%#{params[:user_id][:filter]}%"
    end

    if params[:nickname].present? && params[:nickname][:filter].present?
      search << "nickname like :nickname"
      search_params.merge! nickname: "%#{params[:nickname][:filter]}%"
    end

    if params[:grad_year].present? && params[:grad_year][:filter].present?
      search << "grad_year like :grad_year"
      search_params.merge! grad_year: "%#{params[:grad_year][:filter]}%"
    end

    if params[:major].present? && params[:major][:filter].present?
      search << "major like :major"
      search_params.merge! major: "%#{params[:major][:filter]}%"
    end

    @users = User.where(search.join(' AND '), search_params)
  end

  def show
    @user = User.find(params[:id])
    @request = FriendRequest.where(from_user_id: session[:cas_user], to_user_id: params[:id]).first
    @check_ins = CheckIn.where(user_id: params[:id]).count
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to user_path(@user)
    else
      render action: :edit
    end
  end

  def send_friend_request
    from = session[:cas_user]
    to = params[:id]

    if FriendRequest.where(from_user_id: from, to_user_id: to).blank?
      request = FriendRequest.new(from_user_id: from, to_user_id: to, acceptance_status: FriendRequest.acceptance_statuses[:no_response])
      request.save
    end

    redirect_to user_url(to)
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :grad_year, :major)
  end

end
