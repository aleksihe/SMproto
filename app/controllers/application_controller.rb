#coding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  helper :all
  before_filter :set_no_cache
  before_filter :signed_in_user
  before_filter :update_last_seen
  
  def set_no_cache
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
  private
  def signed_in_user
    redirect_to root_url, notice: "Ole hyvä ja kirjaudu sisään." unless signed_in?
  end
  def update_last_seen
    current_user.update_attribute(:last_seen, DateTime.now)
  end
end
