Rails.application.routes.draw do
  get 'digits/create'

  root to: 'pages#index'

  resources 'digits', only: [:create]
  resources 'users',  only: [:edit, :update]
  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
