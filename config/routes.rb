Rails.application.routes.draw do
  namespace :api do
  namespace :v1 do
    resources :customers, only: [:index, :show ], defaults: {format: :json} do
       collection do
         get 'find'
       end
     end

    resources :merchants, only: [:index, :show], defaults: { format: :json } do
      collection do
        get 'find'
      end
    end
    
    resources :transactions, only: [:index, :show, :find, :find_all], defaults: { format: :json }
    resources :items, only: [:index, :show, :find, :find_all], defaults: { format: :json }
    resources :invoices, only: [:index, :show, :find, :find_all], defaults: { format: :json }
    resources :invoice_items, only: [:index, :show, :find, :find_all], defaults: { format: :json }
    end
  end
end
