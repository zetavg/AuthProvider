require "rails_helper"

RSpec.describe "Resource Owner Password Credentials Grant Flow", type: :request do
  let(:user) { User.create!(username: 'user', password: 'password') }
  let(:credentials) do
    {
      grant_type: :password,
      username: user.username,
      password: user.password
    }
  end

  subject do
    if Rails.version.to_i >= 5
      post "/oauth/tokens", params: credentials
    else
      post "/oauth/tokens", credentials
    end
  end

  it "returns a valid access token for the authenticated resource owner" do
    subject

    expect(response).to be_success
    expect(response).to have_http_status(200)
    expect(json).to have_key('access_token')
    user_from_accsee_token = AuthProvider.resource_owner_from_token(json['access_token'])
    expect(user_from_accsee_token).to eq(user)
  end

  context "with access_token_expires_in set" do
    before do
      AuthProvider.config.access_token_expiration_time = 20.hours
    end

    it "returns a token with the specific expires_in time" do
      subject
      expect(json).to have_key('created_at')
      expect(json['expires_in']).to eq(72_000)
    end
  end

  context "using refresh token" do
    before do
      # TODO
    end

    it "returns a refresh token" do
      subject
      expect(json).to have_key('refresh_token')
    end
  end

  context "with invalid credentials" do
    let(:credentials) do
      {
        grant_type: :password,
        username: user.username,
        password: 'wrong_password'
      }
    end

    it "returns invalid_grant error with 400" do
      subject

      expect(response).not_to be_success
      expect(response).to have_http_status(400)
      expect(json).not_to have_key('access_token')
      expect(json['error']).to eq('invalid_grant')
    end
  end
end
