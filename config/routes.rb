Rails.application.routes.draw do

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do

    root to: "home#index"

    #DEVISE:
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)

    devise_for :clients, controllers: { registrations: 'client/registrations', sessions: 'client/sessions' }

    devise_for :sellers, controllers: { registrations: 'seller/registrations', sessions: 'seller/sessions' }, path_names: { registration: ENV['NEW_SELLER_PATH'] }

    #DASHBOARDS:
    get "c/:id/dashboard" => 'dashboard_clients#show', as: :client_dashboard
    resources :clients, path: "c", only: [:edit, :update, :destroy], path_names: { edit: "account" } do
      resource :basket, only: [:edit, :update], path_names: { edit: "" }
    end

    get "s/:id/dashboard" => 'dashboard_sellers#show', as: :seller_dashboard
    resources :sellers, path: "s", only: [:show, :edit, :update], path_names: { edit: "account" } do
      resources :products, path: "p", path_names: { edit: "edit" }
    end

    #CATALOG:
    get '/catalogue', to: 'products#index', as: 'catalogue'

    resources :products, only: [:index, :show]

    # concern :manageable do
    #   resources :conversations, :orders...
    # end
  end
end
