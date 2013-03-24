Resonanz::Application.routes.draw do
  scope '(:locale)', locale: /en|ru/ do
    get 'create_identity' => 'sessions#create', as: 'create_identity'

    root to: 'conversations#index'

    resources :conversations, only: [:show, :create, :index] do
      resources :messages, only: [:create]
    end
  end
end
