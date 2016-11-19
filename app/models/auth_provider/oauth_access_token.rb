module AuthProvider
  class OAuthAccessToken < ApplicationRecord
    scope :not_revoked, -> { where(revoked_at: nil) }

    belongs_to :oauth_session

    delegate :resource_owner, to: :oauth_session, prefix: false

    after_initialize :init_token
    after_initialize :init_refresh_token
    after_initialize :init_expires_in

    def valid?(*args)
      super(*args) && !revoked? && !expired?
    end

    def expired?
      Time.now > (created_at || Time.now) + expires_in.seconds
    end

    def revoked?
      revoked_at.present? || oauth_session.revoked?
    end

    def use!
      fail unless valid?
      revoke_other_access_tokens_of_the_session!
    end

    def revoke!
      update_attributes!(revoked_at: Time.current)
    end

    def revoke_other_access_tokens_under_the_session!
      oauth_session.oauth_access_tokens.not_revoked.where.not(id: id).update_all(revoked_at: Time.current)
    end

    private

    def init_token
      self.token ||= SecureRandom.hex(64)
    end

    def init_refresh_token
      self.refresh_token ||= SecureRandom.hex(64)
    end

    def init_expires_in
      self.expires_in ||= 7200
    end
  end
end
