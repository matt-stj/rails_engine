Rails.application.routes.draw do

  get "/", to: "pages#index"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#delete"

  resources :users, only: [:show]

  namespace :api do
  namespace :v1 do
      resources :customers, only: [:index, :show ], defaults: {format: :json} do
        resources :invoices, module: "customers", only: [:index]
        resources :transactions, module: "customers", only: [:index]
        resource :favorite_merchant, module: "customers", only: [:show]

         collection do
           get 'find'
           get 'find_all'
           get 'random'
         end
       end

      resources :merchants, only: [:index, :show], defaults: { format: :json } do
        resources :items, module: "merchants", only: [:index]
        resources :invoices, module: "merchants", only: [:index]

        resource :revenue, module: "merchants", only: [:show]
        resource :favorite_customer, module: "merchants", only: [:show]
        resources :customers_with_pending_invoices, module: "merchants", only: [:index]

        collection do
          get 'find'
          get 'find_all'
          get 'random'
          get '/most_revenue', to: 'merchants/most_revenue#index'
          get '/revenue', to: 'merchants/total_revenue#show'
        end

      end

      resources :transactions, only: [:index, :show], defaults: { format: :json } do
        resource :invoice, module: "transactions", only: [:show]
        collection do
          get 'find'
          get 'find_all'
          get 'random'
        end
      end

      resources :items, only: [:index, :show], defaults: { format: :json } do
        resources :invoice_items, module: "items", only: [:index]
        resource :merchant, module: "items", only: [:show]
        resource :best_day, module: "items", only: [:show]

        collection do
          get 'find'
          get 'find_all'
          get 'random'
          get '/most_revenue', to: 'items/most_item_revenue#index'
        end
      end

      resources :invoices, only: [:index, :show], defaults: { format: :json }  do
        resources :transactions, module: "invoices", only: [:index]
        resources :invoice_items, module: "invoices", only: [:index]
        resources :items, module: "invoices", only: [:index]
        resource :customer, module: "invoices", only: [:show]
        resource :merchant, module: "invoices", only: [:show]

        collection do
          get 'find'
          get 'find_all'
          get 'random'
        end
      end

      resources :invoice_items, only: [:index, :show], defaults: { format: :json }  do
        resource :invoice, module: "invoice_items", only: [:show]
        resource :item, module: "invoice_items", only: [:show]

        collection do
          get 'find'
          get 'find_all'
          get 'random'
        end
      end

    end
  end
end
