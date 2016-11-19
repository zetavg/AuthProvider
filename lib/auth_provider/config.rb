module AuthProvider
  class MissingConfiguration < StandardError
    def initialize
      super('Configuration for auth_provider missing.')
    end
  end

  def self.configure(&block)
    @config = Config::Builder.new(&block).build
  end

  def self.configuration
    @config || (fail MissingConfiguration)
  end

  class Config
    attr_accessor :default_resource_owner_type
    attr_accessor :resource_owner_from_credentials

    class Builder
      def initialize(&block)
        @config = Config.new

        instance_eval(&block)

        @config.default_resource_owner_type ||= 'User'
      end

      def build
        @config
      end

      def default_resource_owner_type(type)
        @config.default_resource_owner_type = type.to_s
      end

      def resource_owner_from_credentials(&block)
        @config.resource_owner_from_credentials = block
      end
    end
  end
end
