class ApplicationController < ActionController::Base
  before_action :set_locale, :set_current_basket

  private
    def set_locale
      I18n.locale = params[:locale] if params[:locale].present?
    end

    def default_url_options(options = {})
      { locale: I18n.locale }
    end

    def set_current_basket
      if current_client
        @current_basket = current_client.basket
      else
        unless cookies['basket_id']
          @current_basket = Basket.create!
          cookies['basket_id'] = @current_basket.id
        else
          @current_basket = Basket.find(cookies['basket_id'])
        end
      end
    end
    
    # rescue_from CanCan::AccessDenied do |exception|
    #   flash[:error] = "Access denied!"
    #   redirect_to root_url
    # end
    
    def current_ability
      seller_check = ["products", "sellers", "dashboard_sellers"]
      if seller_check.include? params[:controller]
        @current_ability ||= ::Ability.new(current_seller)
      end
      client_check = ["baskets", "clients", "dashboard_clients"]
      if client_check.include? params[:controller]
        @current_ability ||= ::Ability.new(current_client)
      end
    end
end
