# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true
end

def login_as_user_id(id)
  session[:user_id] = id
end

def add_pomodoro_for_user_id(id)
  pomodoro = Pomodoro.new(:user_id=>id, :start_time=>Time.now)
  pomodoro.save()
end

def create_pomodoro_array(count)
    pomodoros = []
    # inject total methods for kaminari
    pomodoros.instance_eval <<-EVAL
      def total_count
        [count, 10].min
      end

      def current_page
        1
      end

      def num_pages
        count/10
      end

      def   limit_value
        10
      end
    EVAL

    count.times do
      pomodoros << Pomodoro.new(:user_id=>1, :start_time=>Time.now)
    end
    pomodoros
  end