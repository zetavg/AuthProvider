require_dependency "auth_provider/application_controller"

module AuthProvider
  class TokensController < ApplicationController
    def create
      case grant_type
      when "password"
        if resource_owner.blank?
          render(status: 400, json: {
            error: "invalid_grant",
            error_description: "Invalid username or password."
          }) and return
        end

        oauth_session = OAuthSession.create!(
          resource_owner: resource_owner,
          device_type: device_type,
          device_identifier: device_identifier,
          device_name: device_name
        )

        oauth_access_token = oauth_session.oauth_access_tokens.create!

        render(status: 200, json: {
          access_token: oauth_access_token.token,
          token_type: "bearer",
          created_at: oauth_access_token.created_at.to_i,
          expires_in: oauth_access_token.expires_in,
          refresh_token: oauth_access_token.refresh_token
        }) and return

      when "refresh_token"
        old_oauth_access_token = OAuthAccessToken.not_revoked.find_by(refresh_token: refresh_token)

        if old_oauth_access_token.blank?
          render(status: 400, json: {
            error: "invalid_grant",
            error_description: "The refresh token is invalid."
          }) and return
        end

        oauth_access_token = old_oauth_access_token.oauth_session.oauth_access_tokens.create!

        render(status: 200, json: {
          access_token: oauth_access_token.token,
          token_type: "bearer",
          created_at: oauth_access_token.created_at.to_i,
          expires_in: oauth_access_token.expires_in,
          refresh_token: oauth_access_token.refresh_token
        }) and return

      else
        render(status: 400, json: {
          error: "unsupported_grant_type",
          error_description: "Unknown grant type: #{params[:grant_type].presence || 'null'}."
        }) and return
      end
    end

    private

    def grant_type
      @grant_type = params[:grant_type]
    end

    def resource_owner_type
      @resource_owner_type = params[:resource_owner_type] ||
                             AuthProvider.configuration.default_resource_owner_type
    end

    def username
      @username ||= params[:username]
    end

    def password
      @password ||= params[:password]
    end

    def resource_owner
      @resource_owner ||= AuthProvider.configuration.resource_owner_from_credentials.call(
        resource_owner_type, username, password
      )
    end

    def device_type
      @device_type ||= params[:device_type]
    end

    def device_identifier
      @device_identifier ||= params[:device_identifier]
    end

    def device_name
      @device_name ||= params[:device_name]
    end

    def refresh_token
      @refresh_token ||= params[:refresh_token]
    end
  end
end
