class HomeController < ApplicationController
  def index
    @categories = get_locale_categories
    @sellers = get_locale_sellers
    @tags = get_locale_tags
  end
end