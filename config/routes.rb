Mars::Application.routes.draw do

  get "events/index"

  root :to => 'home#index'
  get "home/index"
  get "addresses/index"
  get "contacts/index" => "contacts#index", as: "contacts"
  get "contacts/:id" => "contacts#show", as: "contact"
  get "quotation_lines/index"
  put "projects/:id/close" => "projects#close", as: "close_project"
  put "quotations/:id/issue" => "quotations#issue", as: "issue_quotation"
  put "quotations/:id/reopen" => "quotations#reopen", as: "reopen_quotation"
  put "quotations/:id/cancel" => "quotations#cancel", as: "cancel_quotation"
  put "sales_orders/:id/issue" => "sales_orders#issue", as: "issue_sales_order"
  put "sales_orders/:id/reopen" => "sales_orders#reopen", as: "reopen_sales_order"
  put "sales_orders/:id/cancel" => "sales_orders#cancel", as: "cancel_sales_order"
  put "sales_orders/:id/accept" => "sales_orders#accept", as: "accept_sales_order"
  put "sales_orders/:id/invoice" => "sales_orders#invoice", as: "invoice_sales_order"
  put "sales_orders/:id/paid" => "sales_orders#paid", as: "paid_sales_order"
  post "quotations/:id/convert" => "quotations#convert", as: "convert_quotation"
  get "quotations/:id/emails" => "quotations#list_emails", as: "quotation_emails"
  get "quotations/:id/events" => "quotations#list_events", as: "quotation_events"
  get "sales_orders/:id/emails" => "sales_orders#list_emails", as: "sales_order_emails"
  get "sales_orders/:id/events" => "sales_orders#list_events", as: "sales_order_events"
  get "emails/:id/download_attachment" => "emails#download_attachment", as: "email_attachment"
  get "purchase_orders/setup" => "purchase_orders#setup", as: "setup_purchase_order"
  get "purchase_orders/:id/issue" => "purchase_orders#issue", as: "issue_purchase_order"
  get "purchase_orders/:id/reopen" => "purchase_orders#reopen", as: "reopen_purchase_order"
  get "purchase_orders/:id/cancel" => "purchase_orders#cancel", as: "cancel_purchase_order"
  get "purchase_orders/:id/receipt" => "purchase_orders#receipt", as: "receipt_purchase_order"
  get "purchase_orders/:id/paid" => "purchase_orders#paid", as: "paid_purchase_order"
  get "purchase_orders/:id/emails" => "purchase_orders#list_emails", as: "purchase_order_emails"
  get "purchase_orders/:id/events" => "purchase_orders#list_events", as: "purchase_order_events"
  
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

  resources :sales_orders
  resources :sales_order_lines
  resources :purchase_order_lines
  resources :quotation_lines
  resources :purchase_orders

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
