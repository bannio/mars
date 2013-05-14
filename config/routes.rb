Mars::Application.routes.draw do

  root :to => 'home#index'
  get "home/index"
  get "addresses/index"
  get "contacts/index"
  get "quotation_lines/index"
  put "quotation/:id/issue" => "quotations#issue", as: "issue_quotation"
  put "quotation/:id/reopen" => "quotations#reopen", as: "reopen_quotation"
  put "sales_order/:id/issue" => "sales_orders#issue", as: "issue_sales_order"
  put "sales_order/:id/reopen" => "sales_orders#reopen", as: "reopen_sales_order"
  put "sales_order/:id/cancel" => "sales_orders#cancel", as: "cancel_sales_order"
  put "sales_order/:id/accept" => "sales_orders#accept", as: "accept_sales_order"
  put "sales_order/:id/invoice" => "sales_orders#invoice", as: "invoice_sales_order"
  put "sales_order/:id/paid" => "sales_orders#paid", as: "paid_sales_order"
  post "quotation/:id/convert" => "quotations#convert", as: "convert_quotation"
  
  resources :companies do
    resources :contacts
    resources :addresses
  end
  resources :projects
  resources :emails
  
  resources :quotations do
    # get :email
    collection {post :import }
  end

  resources :sales_orders do
    # put :reopen
    # get :email
  end

  resources :sales_order_lines
  resources :quotation_lines

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
