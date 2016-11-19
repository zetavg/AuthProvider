AuthProvider.configure do
  default_resource_owner_type "User"

  resource_owner_from_credentials do |_type, username, password|
    User.find_by(username: username, password: password)
  end
end
