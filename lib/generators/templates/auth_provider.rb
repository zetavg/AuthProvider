AuthProvider.configure do
  default_resource_owner_type "User"

  resource_owner_from_credentials do |type, username, password|
    user_class = type.constantize
    user = user_class.find_for_database_authentication(email: username)
    if user.valid_password?(password)
      user
    else
      nil
    end
  end
end
