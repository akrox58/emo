class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def verify_authorized
  	if current_user
  		return
  	else
  		redirect_to root_path
  	end
  end
end
