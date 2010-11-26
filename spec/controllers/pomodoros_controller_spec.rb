require 'spec_helper'

describe PomodorosController do
  fixtures :users
  describe "pomodoros with rendered view" do
    render_views
    it "new should succeed without login" do
      get :new
      response.should be_success
    end
  end


  it "index should redirect to sessions when no user is logged in" do
    get :index
    response.should redirect_to(sessions_path)
    flash[:error].should include("You must be logged in")
  end

  it "index should be available when user is logged in" do
    login_as_test_user
    get :index
    response.should be_success
  end
end
