class PomodorosController < ApplicationController
  before_filter :require_login, :except=>[:new]

  def index

  end

  def new

  end

private
  def require_login
    unless signed_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to sessions_url # halts request cycle
    end
  end
end
