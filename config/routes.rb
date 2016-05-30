Rails.application.routes.draw do

  root 'articles#index'

  resources :articles do
  	member do
      put 'close' => 'articles#close'
      put 'open' => 'articles#open'
    end
   end

  resources :activities do
    member do
      put 'close' => 'activities#close'
      put 'open' => 'activities#open'
    end
  end

  resources :users, except: [:new]
  resources :pictures, except: [:update,:edit]
  resources :films, except: [:show]

  get 'tags/:tag' => 'articles#index',as: :tag
  get 'columns' => 'articles#columns'
  get 'signup' => 'users#signup',:as => 'signup'
  get "login" => "users#login", :as => "login"
  post "create_login_session" => "users#create_login_session"
  delete "logout" => "users#logout", :as => "logout"

end
