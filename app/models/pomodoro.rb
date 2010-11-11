class Pomodoro < ActiveRecord::Base
  belongs_to :user

  def self.active_pomodoro(user_id)
    Pomodoro.where(["user_id = ? AND finished = ?", user_id, false]).first
  end

  def remaining_time_in_millis
    now = Time.now.gmtime
    time_in_millis = (start_time.to_i*1000 + Pomodoro.pomodoro_time_in_millis) - now.to_i*1000
    if time_in_millis < 0
      return 0
    end
    time_in_millis
  end

  def self.pomodoro_time_in_millis
    25*60*1000
  end

  def displayed_start_time
    start_time.strftime("%Y-%m-%d %H:%M:%S")
  end

  def state
    return "In Progress" unless finished
    return "Cancelled" unless success
    "Finished"
  end
end
