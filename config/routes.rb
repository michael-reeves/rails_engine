Rails.application.routes.draw do
  namespace :api,  defaults: { format: :json } do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        #  get 'find'
        collection do
          get 'find'
          get 'find_all'
          get 'random'
        end
      end

      resources :customers, only: [:index, :show] do
        #  get 'find'
        collection do
          get 'find'
          get 'find_all'
          get 'random'
        end
      end
    end
  end

end
