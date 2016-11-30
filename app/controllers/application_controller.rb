class ApplicationController < ActionController::Base
  before_action CASClient::Frameworks::Rails::Filter
  before_action :authenticate
  protect_from_forgery with: :exception

  def authenticate
    if User.where(UserID: session[:cas_user]).blank?
      User.create(UserID: session[:cas_user])
    end
  end
end
