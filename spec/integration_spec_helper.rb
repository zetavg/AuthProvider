ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../dummy/config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "spec_helper"
require "rspec/rails"
ActiveRecord::Migrator.migrations_paths = [File.expand_path('../dummy/db/migrate', __FILE__)]
ActiveRecord::Migration.maintain_test_schema!
