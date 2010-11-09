class PomodorosController < ApplicationController
  before_filter :require_login, :except=>[:new]

  def index

  end

  def new
    if current_user == nil
      @remaining_time = Pomodoro.pomodoro_time_in_millis
      return
    end
    pomodoro = Pomodoro.active_pomodoro(current_user)
    puts "active pomodoro is #{pomodoro}"

    if(pomodoro == nil)
      pomodoro = Pomodoro.new
      pomodoro.user = current_user
      pomodoro.start_time = Time.now
      pomodoro.save
    end


    @remaining_time = pomodoro.remaining_time_in_millis
    puts "remaining pomodoro time = #{@remaining_time}"
  end

private
  def require_login
    unless signed_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to sessions_url # halts request cycle
    end
  end
end
