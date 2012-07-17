module SessionsHelper
  def sign_in(user)
    session[:remember_token] = user.id
    self.current_user = user
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= User.find(session[:remember_token])
  end
end
