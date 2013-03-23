Resonanz::Application.routes.draw do
  get 'create_identity' => 'sessions#create', as: 'create_identity'

  root to: 'conversations#index'
end
