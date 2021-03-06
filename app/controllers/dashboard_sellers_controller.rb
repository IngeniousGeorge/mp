class DashboardSellersController < ApplicationController
  before_action :authenticate_seller!
  before_action :unauthorize_tempered_urls
  load_and_authorize_resource :seller, find_by: :slug

  def show
    @seller = current_seller
    @lang = @seller.available_translations
    @products = @seller.products
    @prod_lang = {}
    @products.each { |product| @prod_lang[product.slug] = product.available_translations }
    @locations = @seller.locations
    @sales = @seller.sales
    @new_product = @seller.products.new
    @new_product.prepare_empty_tags
    @new_product.prepare_empty_translations
  end

  private

  def unauthorize_tempered_urls
    if params[:id] != current_seller.slug
      redirect_to root_path, notice: "Invalid URL" 
    end
  end
  
  def current_ability
    @current_ability ||= ::Ability.new(current_seller)
  end
end
