Rails.application.routes.draw do
  namespace :api,  defaults: { format: :json } do
    namespace :v1 do

      get 'merchants/:merchant_id/revenue', to: 'merchants#merchant_revenue'
      resources :merchants, only: [:index, :show] do
        get 'items'
        get 'invoices'
        # get 'revenue', to: 'merchants#merchant_revenue'

        collection do
          get 'find'
          get 'find_all'
          get 'random'
          get 'most_revenue'
          get 'most_items'
          get 'revenue'
        end
      end

      resources :customers, only: [:index, :show] do
        get 'invoices'
        get 'transactions'
        get 'favorite_merchant'

        collection do
          get 'find'
          get 'find_all'
          get 'random'
        end
      end

      resources :items, only: [:index, :show] do
        get 'invoice_items'
        get 'merchant'

        collection do
          get 'find'
          get 'find_all'
          get 'random'
        end
      end

      resources :invoices, only: [:index, :show] do
        get 'transactions'
        get 'invoice_items'
        get 'items'
        get 'customer'
        get 'merchant'

        collection do
          get 'find'
          get 'find_all'
          get 'random'
        end
      end

      resources :invoice_items, only: [:index, :show] do
        get 'invoice'
        get 'item'

        collection do
          get 'find'
          get 'find_all'
          get 'random'
        end
      end

      resources :transactions, only: [:index, :show] do
        get 'invoice'

        collection do
          get 'find'
          get 'find_all'
          get 'random'
        end
      end
    end
  end

end
