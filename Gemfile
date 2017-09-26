source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'administrate'
gem 'angular-rails-templates'
gem 'angularjs-rails'
gem 'bower-rails', '~> 0.11.0'
gem 'coffee-rails', '~> 4.2'
gem 'devise', '~> 4.2'
gem 'foreman'
gem 'httparty', '~> 0.13.7'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.3'
gem 'sass-rails', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
gem 'chartkick'
gem 'highcharts-rails'
gem 'rack-timeout'
group :development, :test do
  # Call 'byebug' anywhere in the code to stop
  # execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'pry'
  gem 'rspec-rails', '~> 3.5'
  gem 'rubocop', '~> 0.49.1', require: false
  gem 'selenium-webdriver'
  gem 'sqlite3'
end

group :test do
  gem 'shoulda-matchers', '~> 3.1'
  gem 'vcr'
  gem 'webmock', '~> 2.1'
end

group :production do
  gem 'pg'
end

group :production, :staging do
  gem 'rails_12factor'
  gem 'rails_serve_static_assets'
  gem 'rails_stdout_logging'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your
  # application running in the background.
  # Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Access an IRB console on exception pages or
  # by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
ruby '2.3.3'
