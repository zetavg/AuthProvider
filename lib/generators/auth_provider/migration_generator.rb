require 'rails/generators/base'

module AuthProvider
  module Generators
    class MigrationGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path("../templates", __FILE__)

      desc "Creates the AuthProvider migration file."

      def copy_migration_file
        migration_template "create_auth_provider_tables.rb", "db/migrate/create_auth_provider_tables.rb"
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
