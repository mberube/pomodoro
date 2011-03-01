class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_timezone

  protected

  def current_user
     user_id = session[:user_id]
     puts "current user id = #{user_id} for session #{session}"
     @current_user ||= User.find_by_id(user_id)
  end

  def signed_in?
    signed_in = !!current_user
    puts "signed in? = #{signed_in}"
    signed_in
  end

  helper_method :current_user, :signed_in?, :require_login

  def current_user=(user)
    @current_user = user
    puts "settings current user id to #{user.id}"
    session[:user_id] = user.id
  end

  # The browsers give the # of minutes that a local time needs to add to
  # make it UTC, while TimeZone expects offsets in seconds to add to
  # a UTC to make it local.
  def browser_timezone
    return nil if cookies[:tzoffset].blank?
    @browser_timezone ||= begin
      min = cookies[:tzoffset].to_i
      ActiveSupport::TimeZone[-min.minutes]
    end
  end

  def set_timezone
    Time.zone = browser_timezone
  end

end
