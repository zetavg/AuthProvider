require 'integration_spec_helper'

describe AuthProvider::OAuthAccessToken do
  let(:user) { User.create!(username: "user", password: "12345678") }
  let(:oauth_session) { AuthProvider::OAuthSession.create!(resource_owner: user) }
  subject { AuthProvider::OAuthAccessToken.create!(oauth_session: oauth_session) }

  describe 'validations' do
    it 'is invalid without oauth_session_id' do
      subject.oauth_session_id = nil
      expect(subject).not_to be_valid
    end
  end

  describe "class methods" do
    describe ".not_revoked" do
      let!(:available_access_token) { AuthProvider::OAuthAccessToken.create!(oauth_session: oauth_session) }
      let!(:revoked_access_token) { AuthProvider::OAuthAccessToken.create!(oauth_session: oauth_session, revoked_at: Time.current) }
      subject { AuthProvider::OAuthAccessToken.not_revoked }

      it "returns not_revoked OAuthAccessTokens" do
        expect(subject).to include(available_access_token)
        expect(subject).not_to include(revoked_access_token)
      end
    end
  end

  describe "instance methods" do
    describe "#available?" do
      it "returns true if the access token is not revoked, not expired and the session is not revoked" do
        expect(subject.available?).to eq(true)
      end

      it "returns false if the access token is revoked" do
        subject.revoke!
        expect(subject.available?).to eq(false)
      end

      it "returns false if the access token has expired" do
        subject.created_at = Time.current - (subject.expires_in + 1).seconds
        expect(subject.available?).to eq(false)
      end

      it "returns false if the session is revoked" do
        subject.oauth_session.revoke!
        expect(subject.available?).to eq(false)
      end
    end

    describe "#revoked?" do
      it "returns true if revoked_at is not nil" do
        subject.revoked_at = Time.current
        expect(subject.revoked?).to eq(true)
      end

      it "returns true if the session is revoked" do
        subject.oauth_session.revoke!
        expect(subject.revoked?).to eq(true)
      end

      it "returns false if revoked_at is nil and the session is not revoked" do
        subject.revoked_at = nil
        expect(subject.revoked?).to eq(false)
      end
    end

    describe "#expired?" do
      it "returns true if the access token has expired" do
        subject.created_at = Time.current - (subject.expires_in + 1).seconds
        expect(subject.expired?).to eq(true)
      end

      it "returns false if the access token is not expired" do
        subject.created_at = Time.current
        expect(subject.expired?).to eq(false)
      end
    end

    describe "#revoke!" do
      it "sets revoked_at to the current time and save the record" do
        expect { subject.revoke! }.to change { subject.reload.revoked_at }.from(nil)
      end
    end

    describe "#revoke_other_access_tokens_under_the_session!" do
      let!(:access_token_1) { AuthProvider::OAuthAccessToken.create!(oauth_session: oauth_session) }
      let!(:access_token_2) { AuthProvider::OAuthAccessToken.create!(oauth_session: oauth_session) }
      let!(:access_token_3) { AuthProvider::OAuthAccessToken.create!(oauth_session: oauth_session) }

      it "revokes other access tokens under the same session" do
        other_access_tokens = [access_token_1, access_token_2, access_token_3]

        expect do
          subject.revoke_other_access_tokens_under_the_session!
        end.to change { other_access_tokens.map(&:reload).map(&:revoked?) }
          .from([false, false, false])
          .to([true, true, true])
      end
    end

    describe "#use!" do
      it "raises an error if the access token is not available" do
        subject.revoke!
        expect { subject.use! }.to raise_error(AuthProvider::OAuthAccessToken::AccessTokenUnavailable)
      end

      it "calls #revoke_other_access_tokens_under_the_session!" do
        expect(subject).to receive(:revoke_other_access_tokens_under_the_session!)
        subject.use!
      end
    end
  end
end
