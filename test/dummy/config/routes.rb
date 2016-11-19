Rails.application.routes.draw do
  mount AuthProvider::Engine => "/auth_provider"
end
