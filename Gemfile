source "https://rubygems.org"

ruby '3.4.1'

gem "rails", "~> 8.0.1"
gem "propshaft"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"
gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false
gem 'nested_scaffold', '~> 1.1'
gem "stimulus_reflex", "~> 3.5"
gem 'devise', '~> 4.9', '>= 4.9.4'

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
  gem 'pg', '~> 1.5', '>= 1.5.9'
end

group :production do
	gem 'pg', '~> 1.5', '>= 1.5.9'
  gem 'rails_12factor', '~> 0.0.3'
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
