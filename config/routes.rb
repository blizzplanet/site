Bru::Application.routes.draw do
  resources :people

  get 'signup' => 'people#new', :as => :signup
  get 'signin' => 'sessions#new', :as => :signin
  delete 'signout' => 'sessions#destroy', :as => :logout

  resource :session, :only => [:new, :create, :destroy]


  # match '/activate/:activation_code' => 'people#activate', :as => :activate, :activation_code => nil
end
