class PomodorosController < ApplicationController
  before_filter :require_login, :except=>[:new]

  def index
    puts "show pomodoros for #{current_user.id}"
    @pomodoros = Pomodoro.where(:user_id=>current_user.id).order("created_at desc").page(params[:page]).per(10)
  end

  def new
    if current_user == nil
      @remaining_time = Pomodoro.pomodoro_time_in_millis
      return
    end
    @pomodoro = Pomodoro.active_pomodoro(current_user)

    if @pomodoro && @pomodoro.time_elapsed?
      # reset pomodoro
      @pomodoro.finished = true
      @pomodoro.success = true
      @pomodoro.save
      @pomodoro = nil
    end
    @running_pomodoro_detected = @pomodoro != nil

    if(@pomodoro == nil)
      @pomodoro = Pomodoro.new(:user=>current_user, :start_time=>Time.now)
      @pomodoro.save
    end

    @remaining_time = @pomodoro.remaining_time_in_millis
  end

  def close
    pomodoro = Pomodoro.active_pomodoro(current_user)
    redirect_to :new_pomodoro if pomodoro == nil
    pomodoro.finished = true
    pomodoro.success = true
    pomodoro.save
    redirect_to :new_pomodoro
  end

  def cancel
    pomodoro = Pomodoro.active_pomodoro(current_user)
    redirect_to :controller=>:pomodoros, :action=>:index if pomodoro == nil

    pomodoro.finished = true
    pomodoro.success = false
    pomodoro.save
    redirect_to :controller=>:pomodoros, :action=>:index
  end

  def internal_interruption
    @pomodoro = Pomodoro.active_pomodoro(current_user)
    @pomodoro.internal_interruptions += 1
    @pomodoro.save
  end

  def external_interruption
    @pomodoro = Pomodoro.active_pomodoro(current_user)
    @pomodoro.external_interruptions += 1
    @pomodoro.save
  end

  def statistics
    success = Pomodoro.where(:user_id=>current_user.id, :success=>true).count
    total = Pomodoro.where(:user_id=>current_user.id).count

    @stats = {}
    @stats[:all_time] = {:success=>success, :failures=>(total-success)}
  end


private
  def require_login
    unless signed_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to sessions_url # halts request cycle
    end
  end
end
