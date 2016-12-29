require 'rails/generators/base'

module AuthProvider
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates the AuthProvider initializer and mounts AuthProvider::Engine."

      def copy_initializer_file
        template "auth_provider.rb", "config/initializers/auth_provider.rb"
      end

      def mount_engine
        inject_into_file 'config/routes.rb', :after => "Rails.application.routes.draw do" do
          "\n  mount AuthProvider::Engine => '/oauth'\n"
        end
      end
    end
  end
end
