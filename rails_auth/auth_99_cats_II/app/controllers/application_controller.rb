class ApplicationController < ActionController::Base

  #protect_from_forgery with: :exception
  
  # Since all your controllers inherit from ApplicationController, you can use 
  # any method here in any controller.
  helper_method :current_user # let views see the current_user

  # looks up the user with the current session token
  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  # Reset user's session_token and Update the session hash with the new session_token.
  def login!(user)
    #@current_user = user
    session[:session_token]= user.reset_session_token!
  end

  # Call #reset_session_token! on current_user to invalidate the old token, 
  # but only if there is a current_user. Invalidating the old token guarantees 
  # that no one can login with it. This is good practice in case someone has 
  # stolen the token.
  def logout!
    current_user.reset_session_token! if !current_user.nil?
    session[:session_token] = nil
  end

  # if a user is not logged in, redirect to login page
  def require_current_user!
    redirect_to new_session_url if current_user.nil?
  end

  # if user is signed in, redirect to cats index page
  def require_no_user!
    redirect_to cats_url if current_user
  end
end
