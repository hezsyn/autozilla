source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'
# Default ruby version
ruby '2.5.1'
# Use Puma as the app server
gem 'puma', '~> 3.11', '>= 3.11.4'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 4.1', '>= 4.1.14'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2', '>= 4.2.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5.1', '>= 5.1.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1', '>= 3.1.12'
# Necessary for boot strap to work
gem 'bootstrap', '~> 4.1', '>= 4.1.1'
gem 'jquery-rails', '~> 4.3', '>= 4.3.3'
gem 'rubyzip', '~> 1.2', '>= 1.2.1'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13.0'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '~> 3.6', '>= 3.6.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Creating DB ERD
  gem 'rails-erd', '~> 1.5', '>= 1.5.2'
  # Populate the database with test data.  Run rails populate.  Configure data by editing /lib/task/populate.rb
  gem 'populator', '~> 1.0'
  gem 'faker', '~> 1.8', '>= 1.8.7'
end
gem 'pg', '~> 1.0'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data'
