require 'spec_helper'

describe SessionsController do
  it "should show home if user is not logged in" do
    get :index
    response.should be_success
  end

  it "should redirect to pomodoros if user is logged in" do
    login_as_user_id(1)
    get :index
    response.should redirect_to(pomodoros_path)
  end
end
