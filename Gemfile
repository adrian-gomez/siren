source 'https://rubygems.org'


gem 'rails', '4.1.5'

platform :ruby do
  gem 'sqlite3', '~> 1.3'
  gem 'therubyracer'
end

platform :jruby do
  gem 'jdbc-sqlite3', '~> 3.7'
  gem 'activerecord-jdbcsqlite3-adapter', '~> 1.3', '>= 1.3.10'
  gem 'therubyrhino', '~> 2.0', '>= 2.0.4'
end

gem 'sass-rails', '~> 4.0.3'

gem 'uglifier', '>= 1.3.0'

gem 'haml', '~> 4.0'

gem 'jquery-rails', '~> 3.1'

gem 'turbolinks', '~> 2.3'

group :development do
  gem 'spring', '~> 1.1', '>= 1.1.3'
  gem 'quiet_assets', '~> 1.0', '>= 1.0.3'
end

gem 'yew', '~> 0.0'

group :development, :test do
  gem 'rspec-rails', '~> 3.0.0'
end

group :test do
  gem 'rspec-its', '~> 1.0'
  gem 'simplecov', '~> 0.9', :require => false
  gem 'factory_girl_rails', '~> 4.0'
end