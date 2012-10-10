class SessionsController < ApplicationController
 skip_before_filter :signed_in_user, :only => [:new, :create]
 skip_before_filter :update_last_seen
  def new
    @users = User.all
  end
  
  def create
    user = User.find_by_tunnus(params[:session][:tunnus])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      user.update_attribute(:online, true)
      if user.esimies
        redirect_to esimies_main_path
      else
        redirect_to myyja_main_path
      end
    else
      flash[:error] = "Tarkistappas tunnus ja salasana!"
      redirect_to new_session_path
    end
  end
  
  def destroy
    User.find_by_id(session[:remember_token]).update_attribute(:online, false)
    sign_out
    redirect_to root_path
  end
end
