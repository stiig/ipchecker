require 'sidekiq/web'

Rails.application.routes.draw do
  resources :ips, defaults: { format: 'json' }, only: %i[index show create update destroy]
  root to: 'main#index'
  mount Sidekiq::Web => '/sidekiq'
end
