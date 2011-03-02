source 'http://rubygems.org'

gem 'rails', '3.0.4'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'omniauth'
gem 'jquery-rails'
gem 'haml'
gem 'kaminari'
gem 'gchartrb'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  gem 'capybara'
  gem 'database_cleaner'
  #gem 'cucumber-rails'
  #gem 'cucumber'
  gem 'rspec-rails'
  gem 'spork'
  gem 'launchy'
end

group :development do
  # To use debugger
  gem 'ruby-debug19'
  gem 'ruby-debug-ide19'

  gem 'mongrel'
end

group :development, :production do
  gem 'pg'
end
group :test do
  gem 'sqlite3-ruby', :require => 'sqlite3'
  # webrat is required for rspec for the have_selector method (among other)
  gem 'webrat'
end

