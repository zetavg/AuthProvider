module AuthProvider
  module ApplicationHelper
    def authenticated_resource_owner
      access_token = request.headers[:Authorization]
      return unless access_token
      access_token = access_token.split(' ').last
      AuthProvider.resource_owner_from_token(access_token)
    end
  end
end
