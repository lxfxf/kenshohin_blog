module SessionsHelper
  # Logs in the given user
  def log_in(user)
    session[:user_id] = user.id
  end

  # Remember a user in a persistent session
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !(current_user.nil?)
  end

  #Logs out the current user.
  # If the user then logged out in one windows, clicking the "Log out"
  # link in a second window would result in an error due to the use of
  # current_user. We can avoid this by logging out only if the user is
  # logged in.
  def log_out
    # Specific keys have to be destroyed
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end


end
