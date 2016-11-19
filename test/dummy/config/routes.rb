Rails.application.routes.draw do
  mount AuthProvider::Engine => "/oauth"
end
