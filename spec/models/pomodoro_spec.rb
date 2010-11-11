require 'spec_helper'

describe Pomodoro do
  before :each do
    @pomodoro = Pomodoro.new
  end

  it "should last for 25 minutes" do
    @pomodoro.start_time = Time.now

    @pomodoro.remaining_time_in_millis.should == 25*60*1000
  end

  it "should compute remaining time when 5 minutes have elapsed" do
    @pomodoro.start_time = 5.minutes.ago

    @pomodoro.remaining_time_in_millis.should == 20*60*1000
  end

  it "should compute remaining time when 25 minutes have elapsed" do
    @pomodoro.start_time = 25.minutes.ago

    @pomodoro.remaining_time_in_millis.should == 0
  end

  it "should compute remaining time when pomodoro is finished" do
    @pomodoro.start_time = 30.minutes.ago

    @pomodoro.remaining_time_in_millis.should == 0
  end

  it "should have 'In Progress' state if not finished" do
    @pomodoro.finished = false
    @pomodoro.state.should == "In Progress"
  end

  it "should have 'Finished' state if finished successfully" do
    @pomodoro.finished = true
    @pomodoro.success = true
    @pomodoro.state.should == "Finished"
  end

  it "should have 'Cancelled' state if finished unsuccessfully" do
    @pomodoro.finished = true
    @pomodoro.success = false
    @pomodoro.state.should == "Cancelled"
  end

end
