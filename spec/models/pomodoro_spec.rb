require 'spec_helper'

describe Pomodoro do
  it "should last for 25 minutes" do
    pomodoro = Pomodoro.new
    pomodoro.start_time = Time.now

    pomodoro.remaining_time_in_millis.should == 25*60*1000
  end

  it "should compute remaining time when 5 minutes have elapsed" do
    pomodoro = Pomodoro.new
    pomodoro.start_time = 5.minutes.ago

    pomodoro.remaining_time_in_millis.should == 20*60*1000
  end

  it "should compute remaining time when 25 minutes have elapsed" do
    pomodoro = Pomodoro.new
    pomodoro.start_time = 25.minutes.ago

    pomodoro.remaining_time_in_millis.should == 0
  end

  it "should compute remaining time when pomodoro is finished" do
    pomodoro = Pomodoro.new
    pomodoro.start_time = 30.minutes.ago

    pomodoro.remaining_time_in_millis.should == 0
  end

end
