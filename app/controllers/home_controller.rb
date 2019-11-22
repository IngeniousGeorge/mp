class HomeController < ApplicationController
  def index
    @categories = get_locale_categories
    @sellers = get_locale_sellers
    @tags = get_locale_tags
  end

  private

    def get_locale_categories
      Category.all_as_hash[params['locale']]
    end

    def get_locale_sellers
      Seller.where('translations LIKE ?', "%" + params['locale'] + "%")
    end

    def get_locale_tags
      ProductTag.where(lang: params['locale']).distinct.pluck(:tag)
    end
end
