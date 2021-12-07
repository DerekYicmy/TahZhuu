Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #frequent uses routes to the top
  root "courses#index"
  get "/", to: "pages#index"
  get "/about", to: "pages#about"

  get "/sign_up", to: "users#sign_up"
  post "/account_verify", to: "users#account_verify"

  get "/sign_in", to: "users#sign_in"
  post "/sign_in/check", to: "users#check"

  delete "/sign_out", to: "users#sign_out"
  
  #resources :courses
  resources :courses do
    member do
      get :buy
  end
    resources :orders, only: [:create] #POST /courses/2/orders <-- route
    #resources :reviews, shallow:true 
    resources :reviews, only: [:create]
  end
  resources :reviews, only: [:destroy]

  
  
  namespace :api do
    namespace :v1 do
        resources :courses, only: [] do
          member do
            post :like
          end
        end
    end
  end
end
