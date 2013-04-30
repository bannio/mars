Mars::Application.routes.draw do

  root :to => 'home#index'
  get "home/index"
  get "addresses/index"
  get "contacts/index"
  get "quotation_lines/index"
  
  resources :companies do
    resources :contacts
    resources :addresses
  end
  resources :projects
  
  resources :quotations do
    put :issue
    put :reopen
    get :email
    collection {post :import }
    resources :quotation_lines
    resources :emails
  end

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
