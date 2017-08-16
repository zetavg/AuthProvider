module Requests
  module JSONHelpers
    def json
      JSON.parse(response.body)
    end
  end
end
