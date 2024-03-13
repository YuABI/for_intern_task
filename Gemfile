source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.3"
# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3"
# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
#gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem "tailwindcss-rails"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"
# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"
# gem "bcrypt", "~> 3.1.7"
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"
gem "view_component"
group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'bullet'
  gem 'factory_bot_rails'
  gem 'gimei'
  gem 'takarabako'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'faker'
  gem 'annotate'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
  gem 'letter_opener'
  gem 'letter_opener_web'
  gem "rack-mini-profiler"
  gem 'listen', '~> 3.3'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop', require: false
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec', require: false
  gem 'brakeman'
  gem 'yard'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "capybara-screenshot"
  gem "selenium-webdriver"
  gem "webdrivers"
end

# Using common
gem 'pg'
gem "hashid-rails"
gem 'cocoon'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'select2-rails'
gem 'holidays'
gem 'holiday_japan'
gem 'activerecord-import'
gem 'active_attr'
gem 'draper'
gem 'loofah' , "~> 2.21.3"
gem 'kaminari'
gem 'unicorn'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
gem 'faraday'
gem 'faraday-retry'

# Add common yet.
gem 'slim-rails'
gem 'active_hash'
gem 'active_type'
gem 'seed-fu'
gem 'highline'
gem 'breadcrumbs_on_rails'
gem 'enumerize'
gem 'config'
gem 'default_value_for'
gem 'moji'
gem 'dotenv-rails'
gem 'exception_notification'
gem 'rack-attack'
gem 'rubyzip'
gem 'rack-user_agent'

# セッションDB管理
gem 'activerecord-session_store'
#マテリアライズド・ビュー
#http://morizyun.github.io/blog/materialized-view-rails-soic/index.html
gem 'scenic'
gem 'gemoji'
gem "view_component"

# Amazon Pay
gem 'rexml'
gem 'xml-simple'
gem 'fast_jsonapi', '~> 1.5'
gem 'jsonapi-serializer', '~> 2.2.0'
gem 'active_model_serializers'
gem 'rack-cors', require: 'rack/cors'
