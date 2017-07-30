Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "events/index"

  root :to => 'home#index'
  get "home/index"
  get "addresses/index"
  get "contacts/index" => "contacts#index", as: "contacts"
  get "contacts/:id" => "contacts#show", as: "contact"
  get "quotation_lines/index"
  post "quotation_lines/sort" => "quotation_lines#sort", as: "sort_quotation_lines"
  post "sales_order_lines/sort" => "sales_order_lines#sort", as: "sort_sales_order_lines"
  post "purchase_order_lines/sort" => "purchase_order_lines#sort", as: "sort_purchase_order_lines"
  put "projects/:id/close" => "projects#close", as: "close_project"
  put "quotations/:id/issue" => "quotations#issue", as: "issue_quotation"
  put "quotations/:id/reopen" => "quotations#reopen", as: "reopen_quotation"
  put "quotations/:id/cancel" => "quotations#cancel", as: "cancel_quotation"
  post "quotations/:id/copy_line/:line_id" => "quotations#copy_line", as: "copy_quotation_line"
  put "sales_orders/:id/issue" => "sales_orders#issue", as: "issue_sales_order"
  put "sales_orders/:id/reopen" => "sales_orders#reopen", as: "reopen_sales_order"
  put "sales_orders/:id/cancel" => "sales_orders#cancel", as: "cancel_sales_order"
  put "sales_orders/:id/accept" => "sales_orders#accept", as: "accept_sales_order"
  put "sales_orders/:id/invoice" => "sales_orders#invoice", as: "invoice_sales_order"
  put "sales_orders/:id/paid" => "sales_orders#paid", as: "paid_sales_order"
  post "sales_orders/:id/copy_line/:line_id" => "sales_orders#copy_line", as: "copy_sales_order_line"
  post "quotations/:id/convert" => "quotations#convert", as: "convert_quotation"
  get "quotations/:id/emails" => "quotations#list_emails", as: "quotation_emails"
  get "quotations/:id/events" => "quotations#list_events", as: "quotation_events"
  get "sales_orders/:id/emails" => "sales_orders#list_emails", as: "sales_order_emails"
  get "sales_orders/:id/events" => "sales_orders#list_events", as: "sales_order_events"
  get "emails/:id/download_attachment" => "emails#download_attachment", as: "email_attachment"
  get "purchase_orders/setup" => "purchase_orders#setup", as: "setup_purchase_order"
  put "purchase_orders/:id/issue" => "purchase_orders#issue", as: "issue_purchase_order"
  put "purchase_orders/:id/reopen" => "purchase_orders#reopen", as: "reopen_purchase_order"
  put "purchase_orders/:id/cancel" => "purchase_orders#cancel", as: "cancel_purchase_order"
  put "purchase_orders/:id/receipt" => "purchase_orders#receipt", as: "receipt_purchase_order"
  put "purchase_orders/:id/paid" => "purchase_orders#paid", as: "paid_purchase_order"
  get "purchase_orders/:id/emails" => "purchase_orders#list_emails", as: "purchase_order_emails"
  get "purchase_orders/:id/events" => "purchase_orders#list_events", as: "purchase_order_events"
  get "purchase_orders/:id/select_order_lines" => "purchase_orders#select_order_lines", as: "select_order_lines"
  post "purchase_orders/:id/create_order_lines" => "purchase_orders#create_order_lines", as: "create_order_lines"
  post "purchase_orders/:id/create_from_search" => "purchase_orders#create_from_search", as: "create_from_search"
  get "purchase_orders/:id/search" => "purchase_orders#search", as: "search_purchase_order_lines"
  post "purchase_orders/:id/copy_line/:line_id" => "purchase_orders#copy_line", as: "copy_purchase_order_line"
  # get "projects/:id" => "projects#show", as: "show_project"

  resources :companies do
    resources :contacts
    resources :addresses
  end
  resources :projects
  resources :emails

  resources :quotations do
    collection {post :import }
  end

  resources :sales_orders
  resources :sales_order_lines
  resources :purchase_order_lines
  resources :quotation_lines
  resources :purchase_orders do
    collection {post :import }
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
