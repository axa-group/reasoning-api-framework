Rails.application.routes.draw do
  devise_for :users
  root to: 'contracts#index'

  resources :contracts, except: [:show] do
    resources :statements do
      get  'diagram', to: :diagram, defaults: { format: 'xml' }
    end
  end

  namespace :admin do
    resources :users do
      post 'send_reset_password_instructions'
    end
  end
end
