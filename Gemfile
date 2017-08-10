source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.3.3'
gem 'rails', '~> 5.0.2'
gem 'will_paginate'
gem 'redis', '~> 3.0'
gem 'hiredis'
gem 'devise_lastseenable'
gem 'dotenv-rails', groups: [:development, :test, :production]
gem 'activeadmin', '~> 1.0.0.pre2'
gem 'paperclip', '~> 4.3'
gem 'devise'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'omniauth-vkontakte'
gem 'bootstrap-sass'

gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
#gem 'slim-rails'
gem 'ransack'
gem 'pry'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'dotenv-rails'
end

group :development do
  gem 'sqlite3'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # code cleanup
  gem 'rubocop',              require: false
  gem 'traceroute',           require: false
  gem 'bullet'
  gem 'brakeman',             require: false
  gem 'rubycritic',           require: false
  gem 'rails_best_practices', require: false
  gem 'simplecov'
end

group :production do
  gem 'pg'
end
