class ApplicationController < ActionController::Base
  before_action CASClient::Frameworks::Rails::Filter
  before_action :authenticate
  protect_from_forgery with: :exception
  helper_method :params

  def authenticate
    if User.where(user_id: session[:cas_user]).blank?
      User.create(user_id: session[:cas_user])
    end
  end
end
