Rails.application.routes.draw do
  resources :ips, defaults: { format: 'json' }, only: %i[index show create update destroy]
  root to: 'main#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
