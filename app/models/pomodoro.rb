class Pomodoro < ActiveRecord::Base
  belongs_to :user

  def self.sorted_pomodoros(user_id)
    self.order("start_time DESC").find(:all, :limit=>20)
  end

  def self.active_pomodoro(user_id)
    Pomodoro.where(["user_id = ? AND finished = ?", user_id, false]).first
  end

  def self.pomodoro_time_in_millis
    25*60*1000
  end

  def remaining_time_in_millis
    now = Time.now.gmtime
    time_in_millis = (start_time.to_i*1000 + Pomodoro.pomodoro_time_in_millis) - now.to_i*1000
    if time_in_millis < 0
      return 0
    end
    time_in_millis
  end

  def displayed_start_time
    puts "timezone = #{Time.zone}"
    start_time.strftime("%Y-%m-%d %H:%M:%S")
  end

  def state
    return "In Progress" unless finished
    return "Cancelled" unless success
    "Finished"
  end

  def time_elapsed?
    remaining_time_in_millis <= 0
  end
end
