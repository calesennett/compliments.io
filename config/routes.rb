Rails.application.routes.draw do
  get 'digits/create'

  root to: 'pages#index'

  resources 'digits', only: [:create]
  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
