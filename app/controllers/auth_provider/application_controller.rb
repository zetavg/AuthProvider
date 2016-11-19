module AuthProvider
  class ApplicationController < ActionController::Base
    after_action :cors_set_access_control_headers

    def cors_preflight_check
      if request.method_symbol == :options
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Methods'] = 'OPTIONS, GET, POST, PUT, PATCH, DELETE'
        headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization'
        headers['Access-Control-Max-Age'] = '1728000'
        head 200
      end
    end

    private

    def cors_set_access_control_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'OPTIONS, GET, POST, PUT, PATCH, DELETE'
      headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization'
      headers['Access-Control-Max-Age'] = '1728000'
    end
  end
end
