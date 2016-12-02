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

  private

  def user_params
    params.require(:user).permit(:nickname, :grad_year, :major)
  end

end
