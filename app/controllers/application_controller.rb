class ApplicationController < ActionController::Base
  before_action :set_locale, :set_current_basket
  before_action :categorizer # only in development

  private

    def set_locale
      if params[:locale].present?
        I18n.locale = params[:locale]
      else
        I18n.locale, params[:locale] = "en", "en"
      end
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

    def categorizer
      Categorize.define_all_as_hash unless defined? Category.all_as_hash
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
