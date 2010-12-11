require 'spec_helper'

describe Pomodoro do
  before :each do
    @user = User.create_from_hash!({'user_info'=>{'email'=>'joe@example.com'}})
    @pomodoro = Pomodoro.new(:user=>@user, :start_time=>Time.now)
  end

  describe "remaining time" do
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
  end

  describe "state" do
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

  it "should find all pomodoros sorted by time" do
    now = Time.now
    future = 1.minute.from_now
    past = 30.seconds.ago

    p1 = Pomodoro.new(:user=>@user, :start_time=>future).save
    p2 = Pomodoro.new(:user=>@user, :start_time=>past).save
    p3 = Pomodoro.new(:user=>@user, :start_time=>now).save

    pomodoros = Pomodoro.sorted_pomodoros(@user.id)
    pomodoros.size.should == 3
    pomodoros[0].start_time.to_i.should == past.to_i
    pomodoros[2].start_time.to_i.should == future.to_i
  end

  it "should be considered finished if there is no remaining time" do
    pomodoro = Pomodoro.new(:user=>@user, :start_time=>30.minutes.ago)
    pomodoro.time_elapsed?.should == true
  end
end
