require 'spec_helper'

describe PomodorosController do
  it "new should succeed" do
    get :new
    response.should be_success
  end

  it "index should redirect to sessions" do
    get :index
    response.should redirect_to(sessions_path)
    flash[:error].should include("You must be logged in")
  end
end
