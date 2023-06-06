source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.8', '>= 5.2.8.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# pagy:
# Pagination for rails
# @see {https://github.com/ddnexus/pagy}
gem 'pagy', '~> 3.5'

# pry-rails:
# Avoid repeating yourself, use pry-rails instead of copying the initializer to every rails project.
# @see {https://github.com/pry/pry-rails}
gem 'pry-rails', '~> 0.3.8'

# RSwag
# Seamlessly adds a Swagger to Rails-based API's 
# @see {https://github.com/rswag/rswag}
gem 'rswag-api'
gem 'rswag-ui'

# multi_json
# Json coder for most of ruby gems, this was installed due to a bug
# https://github.com/intridea/multi_json
gem 'multi_json'

# rack-cors:
# Rack Middleware for handling Cross-Origin Resource Sharing (CORS)
# @see {https://github.com/cyu/rack-cors}
gem 'rack-cors', '~> 1.0.2'

# bcrypt:
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'

# active_model_serializers
# ActiveModel::Serializers allows you to generate your JSON in an object-oriented and convention-driven manner.
# @see {https://github.com/rails-api/active_model_serializers}
gem 'active_model_serializers', '~> 0.10.0'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  gem 'pry-byebug'

  # Rspec necessary gems
  gem 'rspec-rails', '3.8.0'
  gem 'rswag-specs'
  gem 'factory_bot_rails', '4.11.1'
  gem 'faker', '1.9.1'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
