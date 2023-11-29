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

  get "/my_cart", to: "clothes#my_cart", as: "my_cart"
  post "clothe/add-to-cart/:id", to: "clothes#add_to_cart", as: "add_to_cart"
  delete "clothe/remove-from-cart/:id", to: "clothes#remove_from_cart", as: "remove_from_cart"
end
