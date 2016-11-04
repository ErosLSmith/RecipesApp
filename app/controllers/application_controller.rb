class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?, :user_name, :require_user

  def current_user
  	@current_user ||= Chef.find(session[:chef_id]) if session[:chef_id]
  end
  def logged_in?
  	!!current_user
  end
  def user_name
  	@user_name ||= Chef.find(session[:chef_id]).chefname if session[:chef_id]
  end
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in for that action"
      redirect_to root_path
    end
  end

end
