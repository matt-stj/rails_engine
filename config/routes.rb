Rails.application.routes.draw do
  namespace :api do
  namespace :v1 do
      resources :customers, only: [:index, :show ], defaults: {format: :json} do
        resources :invoices, module: "customers", only: [:index]
        resources :transactions, module: "customers", only: [:index]

         collection do
           get 'find'
           get 'find_all'
           get 'random'
         end
       end

      resources :merchants, only: [:index, :show], defaults: { format: :json } do
        resources :items, module: "merchants", only: [:index]
        resources :invoices, module: "merchants", only: [:index]

        #Business Logic All Merchants

        #Business Logic Sinlge Merchant
        resource :revenue, module: "merchants", only: [:show]
        resources :customers_with_pending_invoices, module: "merchants", only: [:index]

        collection do
          get 'find'
          get 'find_all'
          get 'random'
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

        collection do
          get 'find'
          get 'find_all'
          get 'random'
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
