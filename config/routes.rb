Rails.application.routes.draw do
  devise_for :users
  root to: "clothes#home"
  resources :clothes do
    post "/checkout", to: "checkouts#create"
  end
  get "/dashboard", to: "clothes#my_dashboard"
  resources :webhooks, only: [:create]
  get "/success", to: "checkouts#success"
  get "/cancel", to: "checkouts#cancel"
end
