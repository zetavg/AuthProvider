module AuthProvider
  class MissingConfiguration < StandardError
    def initialize
      super('Configuration for auth_provider is missing. Make sure you have run `rails generate auth_provider:install`.')
    end
  end

  def self.configure(&block)
    @config = Config::Builder.new(&block).build
  end

  def self.configuration
    @config || (fail MissingConfiguration)
  end

  class Config
    # Configurations
    attr_accessor :default_resource_owner_type
    attr_accessor :resource_owner_from_credentials
    attr_accessor :access_token_expiration_time

    class Builder
      def initialize(&block)
        @config = Config.new

        instance_eval(&block)

        # Define default
        @config.default_resource_owner_type ||= 'User'
        @config.access_token_expiration_time ||= 2.hours
      end

      def build
        @config
      end

      # Configuration methods

      def default_resource_owner_type(type)
        @config.default_resource_owner_type = type.to_s
      end

      def resource_owner_from_credentials(&block)
        @config.resource_owner_from_credentials = block
      end

      def access_token_expires_in(time)
        @config.access_token_expiration_time = time
      end
    end
  end
end
