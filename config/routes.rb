Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  resources :tasks
  resources :users

  post 'log_in', action: :create, controller: :sessions
end
