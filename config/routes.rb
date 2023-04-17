Rails.application.routes.draw do
  devise_for :users
  root to: "clothes#home"
  resources :clothes
  get "/dashboard", to: "clothes#my_dashboard"
end
