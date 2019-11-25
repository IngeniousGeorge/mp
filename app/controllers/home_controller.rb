class HomeController < ApplicationController
  def index
    @categories = get_locale_categories
    @sellers = get_locale_sellers
    @tags = get_locale_tags
  end

  def about
  end

  def contact
  end
end