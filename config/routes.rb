Rails.application.routes.draw do
  devise_for :users
  root to: "clothes#home"
  resources :clothes, only: %i[index show new create update edit destroy]
  get "/dashboard", to: "clothes#my_dashboard"
end
