require 'spec_helper'


describe 'pomodoros/index.html.haml' do
  describe 'without pomodoros' do
    before :each do
      assign(:pomodoros, create_pomodoro_array(0))
      render
    end

    it "should render appropriate message if no pomodoros are found" do
      rendered.should include(t("pomodoros_not_found"))
    end

    it "should not have paging" do
      rendered.should_not have_selector("nav[@class='pagination']")
    end
  end

  describe 'with one pomodoro' do
    before :each do
      assign(:pomodoros, create_pomodoro_array(1))
      render
    end

    it "should have available statistics" do
      rendered.should include(t("statistics"))
    end

    it "should not have paging" do
      rendered.should_not have_selector("nav[@class='pagination']")
    end
  end

  describe 'with paging' do
    before :each do
      assign(:pomodoros, create_pomodoro_array(20))
      render
    end

    it "should have paging" do
      rendered.should have_selector("nav[@class='pagination']")
    end
  end
end