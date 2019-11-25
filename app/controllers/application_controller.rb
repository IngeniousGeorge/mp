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
      pages_urls = []
      num_pages = max_size / 8
      num_pages = num_pages + 1 if (max_size % 8) > 0
      if num_pages > 1
        query = "?" + query unless query == ""
        page = 1 if page == 0
        previous = page - 1
        next_page = page + 1
        # first
        pages_urls << { text: "«", link: "/#{locale}/#{namespace}/1" + query } if page > 2
        # previous
        pages_urls << { text: previous, link: "/#{locale}/#{namespace}/#{previous}" + query } if page > 1
        # active
        pages_urls << { text: page, link: "/#{locale}/#{namespace}/#{page}" + query, class: "active" } 
        # next
        pages_urls << { text: next_page, link: "/#{locale}/#{namespace}/#{next_page}" + query } if num_pages > page
        # last
        pages_urls << { text: "»", link: "/#{locale}/#{namespace}/#{num_pages}" + query } if num_pages > (page + 1)
        return pages_urls
      else
        return pages_urls
      end
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
