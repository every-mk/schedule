Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations'
      }

      namespace :auth do
        resources :sessions, only: [:index]
      end

      resources :groups, only: [:create, :show, :update, :destroy]
      resources :permissions, only: [:create, :show, :update, :destroy]
      resources :posts, only: [:create, :show, :update, :destroy]
      resources :meetings, only: [:create, :show, :update, :destroy]
      resources :invites, only: [:create, :show, :update, :destroy]
    end
  end
end
