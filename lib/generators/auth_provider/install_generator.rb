require 'rails/generators/base'

module AuthProvider
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path("../templates", __FILE__)

      desc "Creates the AuthProvider initializer and mounts AuthProvider::Engine."

      def copy_migration_file
        migration_template "create_auth_provider_tables.rb", "db/migrate/create_auth_provider_tables.rb"
      end

      def copy_initializer_file
        template "auth_provider.rb", "config/initializers/auth_provider.rb"
      end

      def mount_engine
        route "mount AuthProvider::Engine => '/oauth'"
      end

      def self.next_migration_number(dirname)
        if defined? ActiveRecord::Generators::Base
          ActiveRecord::Generators::Base.next_migration_number(dirname)
        elsif defined? ActiveRecord::Migration
          next_migration_number = current_migration_number(dirname) + 1
          ActiveRecord::Migration.next_migration_number(next_migration_number)
        else
          fail "Can't find a implementation of next_migration_number"
        end
      end
    end
  end
end
