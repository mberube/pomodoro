require 'spec_helper'

describe PomodorosController do
  fixtures :users
  describe "not logged in" do
    describe "pomodoros with rendered view" do
      it "new should succeed without login" do
        get :new
        response.should be_success
      end
    end

    it "redirects index to sessions when no user is logged in" do
      get :index
      response.should redirect_to(sessions_path)
      flash[:error].should include("You must be logged in")
    end
  end

  describe "logged in" do
    before :each do
      login_as_user_id(1)
    end
    it "make index available when user is logged in" do
      get :index
      response.should be_success
    end

    it "finds pomodoros for the current user" do
      add_pomodoro_for_user_id(1)

      get :index
      assigns(:pomodoros).size.should == 1
    end

    it "shows 10 pomodoros at a time" do
      20.times do
        add_pomodoro_for_user_id(1)
      end

      get :index
      assigns(:pomodoros).size == 10
    end

    it "only shows pomodoros for current user" do
      add_pomodoro_for_user_id(2)

      get :index
      assigns(:pomodoros).size.should == 0
    end
  end
end
