Rails.application.routes.draw do

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do

    #home
    root to: 'home#index'
    get '/about', to: 'home#about', as: 'about'
    get '/contact', to: 'home#contact', as: 'contact'
    get '/photos', to: 'home#photos', as: 'photos'
    get '/resume', to: 'home#resume', as: 'resume'
    get '/download_resume', to: "home#download_resume", as: 'download_resume'

    #DEVISE:
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)

    devise_for :clients, controllers: { registrations: 'client/registrations', sessions: 'client/sessions' }

    devise_for :sellers, controllers: { registrations: 'seller/registrations', sessions: 'seller/sessions' }, path_names: { registration: ENV['NEW_SELLER_PATH'] }

    #DASHBOARDS:
    get "c/:id/dashboard" => 'dashboard_clients#show', as: :client_dashboard
    resources :clients, path: "c", only: [:update, :destroy] do
      resource :basket, only: :edit, path: "checkout"
      resources :basket_lines, only: :update, path: "b"
      resources :locations, only: [:create, :update, :destroy], path: "l"
    end

    get "s/:id/dashboard" => 'dashboard_sellers#show', as: :seller_dashboard
    resources :sellers, path: "s", only: [:update] do
      member { patch 'update_cover'}
      member { patch 'attach_image'}
      member { patch 'delete_image'}
      resources :products, only: [:create, :update, :destroy], path: "p" do
        member { patch 'update_cover'}
        member { patch 'attach_image' }
        member { patch 'delete_image' }
      end
      resources :locations, only: [:create, :update, :destroy], path: "l"
    end

    #CATALOGUE:
    resources :products, only: :show

    get '/catalogue(/:page)', to: 'products#index', as: 'catalogue'
    get '/s/:id(/:page)', to: 'products#index_seller', as: 'c_seller'
    get '/c/:id(/:page)', to: 'products#index_category', as: 'c_category'

    #CHECKOUT
    resources :baskets, only: :show
    resources :basket_lines, only: [:create, :update]

    resources :orders, only: [:create]

    # concern :manageable do
    #   resources :conversations, :orders...
    # end
  end
end
