Rails.application.routes.draw do
  namespace :api do
  namespace :v1 do
      resources :customers, only: [:index, :show ], defaults: {format: :json} do
         collection do
           get 'find'
           get 'find_all'
           get 'random'
         end
       end

      resources :merchants, only: [:index, :show], defaults: { format: :json } do
        resources :items, module: "merchants", only: [:index]
        resources :invoices, module: "merchants", only: [:index]

        collection do
          get 'find'
          get 'find_all'
          get 'random'
        end

      end

      resources :transactions, only: [:index, :show], defaults: { format: :json } do
        collection do
          get 'find'
          get 'find_all'
          get 'random'
        end
      end

      resources :items, only: [:index, :show], defaults: { format: :json } do
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
        collection do
          get 'find'
          get 'find_all'
          get 'random'
        end
      end

    end
  end
end
