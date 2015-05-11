source "https://rubygems.org"

# Specify your gem's dependencies in metasploit_data_models.gemspec
gemspec

gem 'metasploit-model', github: 'rapid7/metasploit-model', ref: 'd25cd50353aa6a25fb1b84b158737810c77bad50'

group :development do
  gem 'metasploit-erd', '1.0.0.pre.rails.pre.4.0'
  # embed ERDs on index, namespace Module and Class<ActiveRecord::Base> pages
  gem 'yard-metasploit-erd', '1.0.0.pre.rails.pre.4.0'
end

# used by dummy application
group :development, :test do
  # Upload coverage reports to coveralls.io
  gem 'coveralls', require: false  
  # supplies factories for producing model instance for specs
  # Version 4.1.0 or newer is needed to support generate calls without the 'FactoryGirl.' in factory definitions syntax.
  gem 'factory_girl', '>= 4.1.0'
  # auto-load factories from spec/factories
  gem 'factory_girl_rails'
  
  rails_version_constraint = [
      '>= 4.0.9',
      '< 4.1.0'
  ]
  gem 'rails', *rails_version_constraint
  # Used to create fake data
  gem "faker"
end

group :test do
  # In a full rails project, factory_girl_rails would be in both the :development, and :test group, but since we only
  # want rails in :test, factory_girl_rails must also only be in :test.
  # add matchers from shoulda, such as validates_presence_of, which are useful for testing validations
  gem 'shoulda-matchers'
  # code coverage of tests
  gem 'simplecov', :require => false
  # need rspec-rails >= 2.12.0 as 2.12.0 adds support for redefining named subject in nested context that uses the
  # named subject from the outer context without causing a stack overflow.
  gem 'rspec-rails', '~> 3.2'
  # used for building markup for webpage factories
  gem 'builder'
end
