Bru::Application.routes.draw do
  resources :people
  resources :categories, :only => [:index, :show]
  resources :articles do
    resources :comments, :only => [:create, :update, :destroy]
    member do
      put :approve
      put :unapprove
    end
  end

  get 'signup' => 'people#new', :as => :signup
  get 'signin' => 'sessions#new', :as => :signin
  delete 'signout' => 'sessions#destroy', :as => :logout
  resource :session, :only => [:new, :create, :destroy]

  root :to => "categories#index"
  # match '/activate/:activation_code' => 'people#activate', :as => :activate, :activation_code => nil
end
