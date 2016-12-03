class UsersController < ApplicationController

  def feed
    @user = session[:cas_user]
  end

  def friends
    me = User.where(user_id: session[:cas_user]).first
    @friends = me.friends
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @request = FriendRequest.where(from_user_id: session[:cas_user], to_user_id: params[:id]).first
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
      request = FriendRequest.new(from_user_id: from, to_user_id: to, acceptance_status: 0)
      request.save
    end

    redirect_to user_url(to)
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :grad_year, :major)
  end

end
