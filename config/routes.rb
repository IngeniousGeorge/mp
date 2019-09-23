Rails.application.routes.draw do

  devise_for :sellers
  devise_for :clients
  # scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    root "home#index"
    # devise_for :admin_users, ActiveAdmin::Devise.config
    # ActiveAdmin.routes(self)
  # end
  
end
