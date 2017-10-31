class SessionsController < ApplicationController

  def new

  end

  def create

  end

  def destroy

  end

  def create_from_windows_login
    if !(login = forwarded_user)
      flash[:error] = "Browser did not provide Windows domain user name"
      user = nil
    elsif user = User.authenticated_by_windows_domain(login)
      # user has access rights to system
    else
      flash[:error] = "User has no access rights to application"
    end
    self.current_user = user
    if logged_in?
      # store that next time automatic login should be made
      cookies[:windows_domain] = {:value => 'true', :expires => Time.now + 1.month}
      # Because of IE NTLM strange behavior need to give 401 response with Javascript redirect
      @redirect_to = redirect_back_or_default_url(root_path)
      render :status => 401, :layout => 'redirect'
    else
      render :action => 'new'
    end
  end
  private
    def forwarded_user
      return nil unless x_forwarded_user = request.headers['X-Forwarded-User']
      users = x_forwarded_user.split(',')
      users.delete('(null)')
      users.first
    end

end
