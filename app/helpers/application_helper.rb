module ApplicationHelper

  def logged_in?
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def is_enabled?(status)
    status == 1 ? "Enabled" : "Disabled"
  end

end
