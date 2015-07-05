source 'https://rubygems.org'
ruby "2.2.2"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

####################
#  Blog a Day Gems #
####################

# for user sessions
gem 'sorcery'
# for authorization of user
gem 'cancancan', '~> 1.10'
# for pagination
gem 'kaminari'
# for hiding api tokens from version control
gem 'figaro'
# doe modernizr
gem 'modernizr-rails', '~> 2.7.1'
# Materialize Scss framework
gem 'materialize-sass'
# for awesome icons
gem 'font-awesome-sass'
# for adding a con job for Rails
gem 'whenever', :require => false
# for used to colour output to the terminal. 
gem 'colored'
# markdown render parser
gem 'github-markdown', '~> 0.6.8'
# for api serilization
gem 'active_model_serializers'
# for Cross-Origin Resource Sharing
gem 'rack-cors', :require => 'rack/cors'

group :production do
	# rails 12 Factor gem for more detail Heroku Logs and better assests mangement
	gem 'rails_12factor'

	# adds Heroku Addon Postmark in order to use SMTP on the produciton server
	gem 'postmark-rails'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem "codeclimate-test-reporter", group: :test, require: nil

group :development, :test do
  # Call 'pry-byebug' anywhere in the code to stop execution and get a debugger console
  gem 'pry-byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '1.3.6'

	####################
	#  Blog a Day Gems #
	####################

	# Code syntax highlighting
	gem 'coderay'

	# genorate fake data for testing
	gem 'faker'

	# testing framework to do unit testing
	gem 'rspec-rails'

	# for feature testing with Rspece
	gem 'capybara'

	# create fake objects to test
	gem 'factory_girl_rails'

	# cleans the database after each test
	gem 'database_cleaner', '~> 1.4.1'

	# has four gems that will install
	# pry-rails - It's an amazing replacement for bland 'ol IRB.
	# awesome_print - It's a pretty printer that makes objects, methods, classes, and expressions you print in the repl look nice.
	# quiet_assets - It's log silencer that saves you from having to look at the same 20 GET requests for your assets on each page load in development.
	# did_you_mean - It's a smart tool that gives you spelling suggestions when you get undefined method errors.
	gem 'favorite_things'

	# has two gems that will install
	# better_errors - It's a beautiful replacement for Rails' default error page.
	# binding_of_caller - Lets better_errors have a REPL on the errors page!
  gem 'best_errors'

  # opens emails in the browser
  gem "letter_opener"
end

