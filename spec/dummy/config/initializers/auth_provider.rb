AuthProvider.configure do
  default_resource_owner_type "User"

  resource_owner_from_credentials do |_type, username, password|
    encrypted_password = Digest::MD5.hexdigest(password)
    User.find_by(username: username, encrypted_password: encrypted_password)
  end
end
