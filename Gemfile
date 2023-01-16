source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.6'

gem 'bcrypt'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'faker'
gem 'http'
gem 'jbuilder', '~> 2.7'
gem 'nokogiri', '>= 1.10.8'
gem 'plaid'
gem 'puma', '~> 4.1'
gem 'rails', '6.1'
gem 'sassc-rails'
gem 'sprockets', '< 4'

# design pattern for the app
gem 'interactor'
gem 'activejob-interactor'

group :development do
  gem 'htmlbeautifier'
  gem 'listen', '~> 3.2'
  gem 'rufo'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'tabulo' # Yesuto added this for the scripts/show_data.rb file
  gem 'web-console', '>= 3.3.0'
end

group :development, :test do
  gem 'amazing_print'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'grade_runner', github: 'firstdraft/grade_runner'
  gem 'sqlite3', '~> 1.4.1'
  gem 'pry-rails'
  gem 'table_print'
  gem 'web_git', github: 'firstdraft/web_git'
end

group :development do
  gem 'annotate'
  gem 'better_errors', '2.6'
  gem 'binding_of_caller'
  gem 'draft_generators', github: 'firstdraft/draft_generators', branch: 'winter-2020'
  gem 'rails_db', '2.3.1'
end

group :test do
  gem 'capybara'
  gem 'factory_bot_rails'
  gem 'rspec-html-matchers'
  gem 'rspec-rails'
  gem 'webmock'
end

group :production do
  gem 'pg'
end
