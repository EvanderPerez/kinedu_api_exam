Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    namespace :v1 do
      resources :tasks
      resources :users

      post 'log_in', action: :create, controller: :sessions
    end
  end
end
