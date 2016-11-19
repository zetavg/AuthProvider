AuthProvider::Engine.routes.draw do
  resources :tokens, only: [:create]
  match :tokens, via: [:options], to: 'tokens#cors_preflight_check'
end
