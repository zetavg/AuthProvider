require 'integration_spec_helper'

describe AuthProvider::OAuthSession do
  let(:user) { User.create!(username: "user", password: "12345678") }
  subject { AuthProvider::OAuthSession.create!(resource_owner: user) }

  describe 'validations' do
    it 'is invalid without resource_owner_id' do
      subject.resource_owner_id = nil
      expect(subject).not_to be_valid
    end

    it 'is invalid without resource_owner_type' do
      subject.resource_owner_type = nil
      expect(subject).not_to be_valid
    end
  end

  describe "class methods" do
    describe ".available" do
      let(:user_1) { User.create!(username: "user_1", password: "12345678") }
      let(:user_2) { User.create!(username: "user_2", password: "12345678") }
      let!(:available_session) { AuthProvider::OAuthSession.create!(resource_owner: user_2) }
      let!(:revoked_session) { AuthProvider::OAuthSession.create!(resource_owner: user_2, revoked_at: Time.current) }
      subject { AuthProvider::OAuthSession.available }

      it "returns available OAuthSessions" do
        expect(subject).to include(available_session)
        expect(subject).not_to include(revoked_session)
      end
    end
  end

  describe "instance methods" do
    describe "#available?" do
      it "returns true if the session is not revoked" do
        expect(subject.available?).to eq(true)
      end

      it "returns false if the session is revoked" do
        subject.revoke!
        expect(subject.available?).to eq(false)
      end
    end

    describe "#revoked?" do
      it "returns true if revoked_at is not nil" do
        subject.revoked_at = Time.current
        expect(subject.revoked?).to eq(true)
      end

      it "returns false if revoked_at is nil" do
        subject.revoked_at = nil
        expect(subject.revoked?).to eq(false)
      end
    end

    describe "#revoke!" do
      it "sets revoked_at to the current time and save the record" do
        expect { subject.revoke! }.to change { subject.reload.revoked_at }.from(nil)
      end
    end
  end
end
