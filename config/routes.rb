Rails.application.routes.draw do

  # scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    root "home#index"
    # devise_for :admin_users, ActiveAdmin::Devise.config
    # ActiveAdmin.routes(self)
  # end
  
end
