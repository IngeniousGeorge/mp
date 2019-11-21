class HomeController < ApplicationController
  def index
    @categories = get_locale_categories
    @sellers = Seller.all #discriminate against locales
    @tags = ProductTag.distinct.pluck(:tag)
  end

  private

    def get_locale_categories
      Category.all_as_hash[params['locale']]
    end
end
