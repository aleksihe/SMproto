class SessionsController < ApplicationController
  def new
    @users = User.all
  end
  
  def create
    user = User.find_by_tunnus(params[:session][:tunnus])
    if user && user.authenticate(params[:session][:password])
      sign_in user
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
    sign_out
    redirect_to root_path
  end
end
