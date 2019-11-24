class ApplicationController < ActionController::Base
  before_action :set_locale, :set_current_basket
  before_action :categorizer # only in development

  private

    def categorizer
      Categorize.define_all_as_hash unless defined? Category.all_as_hash
    end

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

    def default_url_options(options = {})
      { locale: I18n.locale }
    end

    def get_locale_categories
      Category.all_as_hash[params['locale']]
    end

    def get_locale_sellers
      Seller.where('translations LIKE ?', "%" + params['locale'] + "%")
    end

    def get_locale_tags
      ProductTag.where(lang: params['locale']).distinct.pluck(:tag)
    end

    def get_pages_urls(locale, namespace, query, page, max_size)
      if page < 5
        first, second, third, fourth, fifth = 1, 2, 3, 4, 5
      else
        first, second, third, fourth, fifth = page - 2, page - 1, page, page + 1, page + 2
      end
      pages_urls = { first => "/#{locale}/#{namespace}/#{first}?" + query,
      second => "/#{locale}/#{namespace}/#{second}?" + query,
      third => "/#{locale}/#{namespace}/#{third}?" + query,
      fourth => "/#{locale}/#{namespace}/#{fourth}?" + query,
      fifth => "/#{locale}/#{namespace}/#{fifth}?" + query }
      return pages_urls
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

    def set_locale
      if params[:locale].present?
        I18n.locale = params[:locale]
      else
        I18n.locale, params[:locale] = "en", "en"
      end
    end

    # rescue_from CanCan::AccessDenied do |exception|
    #   flash[:error] = "Access denied!"
    #   redirect_to root_url
    # end
end
