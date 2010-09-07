Bru::Application.routes.draw do
  resources :people

  match 'signup' => 'people#new', :as => :signup
  match 'register' => 'people#create', :as => :register
  match 'login' => 'sessions#new', :as => :login
  match 'logout' => 'sessions#destroy', :as => :logout

  resource :session, :only => [:new, :create, :destroy]


  # match '/activate/:activation_code' => 'people#activate', :as => :activate, :activation_code => nil
end
