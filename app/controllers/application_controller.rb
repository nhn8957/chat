class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  def current_user
  		return @current_user if @current_user
  		if session[:user_id]
  			@current_user = User.find(session[:user_id])
  		end
  end

  def authenticate_user!
  	redirect_to root_path unless current_user
  end
  			
end
