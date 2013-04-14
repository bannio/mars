Mars::Application.routes.draw do

  root :to => 'home#index'
  get "home/index"
  get "addresses/index"
  get "contacts/index"
  
  resources :companies do
    resources :contacts
    resources :addresses
  end
  resources :projects

  # devise_for :users , :controllers => {:registrations => "users/registrations", :passwords => "users/passwords"}
  devise_for :users, :skip => [:registrations]                                          
      as :user do
        get 'users/edit' => 'users/registrations#edit', :as => 'edit_user_registration'    
        put 'users' => 'users/registrations#update', :as => 'user_registration'            
      end
  
  scope "admin/" do
    resources :users
  end

end
