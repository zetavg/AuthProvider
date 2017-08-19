module AuthProvider
  class Engine < ::Rails::Engine
    isolate_namespace AuthProvider

    config.to_prepare do
      ::ApplicationController.include(AuthProvider::Engine.helpers)
      ::ApplicationController.helper(AuthProvider::Engine.helpers)
    end
  end
end
