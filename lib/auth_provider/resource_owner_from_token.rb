module AuthProvider
  def self.resource_owner_from_token(token)
    oauth_access_token = OAuthAccessToken.find_by(token: token)
    return nil if oauth_access_token.blank? || !oauth_access_token.valid?
    oauth_access_token.use!
    oauth_access_token.resource_owner
  end
end
