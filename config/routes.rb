Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #frequent uses routes to the top
  root "pages#index"
  get "/", to: "pages#index"
  get "/about", to: "pages#about"

  get "/sign_up", to: "users#sign_up"
  post "/account_verify", to: "users#account_verify"

  get "/sign_in", to: "users#sign_in"
  post "/sign_in/check", to: "users#check"
  
end
