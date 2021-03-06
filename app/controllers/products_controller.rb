class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :update_cover, :attach_image, :delete_image, :destroy]
  before_action :set_redirect_path, only: [:create, :update, :update_cover, :attach_image, :delete_image, :destroy]
  before_action :translate_product, only: [:show]
  load_and_authorize_resource :seller, find_by: :slug, only: [:create, :update, :update_cover, :attach_image, :delete_image, :destroy]
  include ProductSql 

  def index
    @namespace = "catalogue"
    get_index_data
  end

  def index_category
    @namespace = "c/" + params['id']
    params['category'] = get_category_id
    redirect_to root_path(params['locale']), alert: "Category not found." and return if params['category'] == "no match"
    @presentee = Category.find(params['category'])
    get_index_data
    presentee_translate
    presentee_placeholder_cover
    render "index"
  end

  def index_seller
    params['seller'] = params['id']
    @namespace = "s/" + params['seller']
    #check if seller exists
    @presentee = Seller.find_by_slug(params['seller'])
    get_index_data
    presentee_translate
    presentee_placeholder_cover
    render "index"
  end

  def show
    @categories = get_locale_categories
    @sellers = get_locale_sellers #.limit(8)
    @tags = get_locale_tags
    @seller = @product.seller
  end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html do
          redirect_to @redirect_path, notice: 'Product was successfully created.'
        end
        format.json { render :show, status: :created, location: @product }
      else
        format.html { redirect_to @redirect_path, alert: "Product wasn't successfully created" + " " + @product.errors[:image].to_s }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @redirect_path, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { redirect_to @redirect_path, alert: "Product wasn't successfully updated" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_cover
    respond_to do |format|
      if @product.cover = params[:product][:cover]
        format.html do
          redirect_to @redirect_path, notice: 'Cover was successfully updated.'
        end
        format.json { render :show, status: :updated, location: @product }
      else
        format.html { redirect_to @redirect_path, alert: "Cover wasn't successfully updated" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def attach_image
    respond_to do |format|
      if @product.images.attach(params[:product][:image])
        format.html do
          redirect_to @redirect_path, notice: 'Image was successfully added.'
        end
        format.json { render :show, status: :updated, location: @product }
      else
        format.html { redirect_to @redirect_path, alert: "Image wasn't successfully added." }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete_image
    image = ActiveStorage::Attachment.find(params[:product][:image_id])
    respond_to do |format|
      if image.purge
        format.html do
          redirect_to @redirect_path, notice: 'Image was successfully deleted.'
        end
        format.json { render :show, status: :updated, location: @product }
      else
        format.html { redirect_to @redirect_path, alert: "Image wasn't successfully deleted." }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to @redirect_path, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private

    def set_product
      @product = Product.friendly.find(params[:id])
    end
      
    def product_params
      params.require(:product).permit(:id, :name, :slug, :category, :description, :price, :price_excl_vat, :price_discount, :price_discount_excl_vat, :translations, :seller_id, :cover, images: [], product_tags_attributes: [:id, :tag, :lang, :product_id, :_destroy], product_translations_attributes: [:id, :lang, :description, :product_id])
    end

    def set_redirect_path
      @redirect_path = seller_dashboard_path(params["seller_id"])
    end

    def translate_product
      @product = @product.translate_object(params['locale']) unless params['locale'] == I18n.default_locale
    end

    def placeholder_images
      @products.each do |product|
        product.set_cover_placeholder unless product.cover.attached?
        product.set_images_placeholder unless product.images.attached?    
      end
    end

    def presentee_placeholder_cover
      @presentee.set_cover_placeholder unless @presentee.cover.attached?   
    end

    def presentee_translate
      @presentee = @presentee.translate_object(params['locale']) unless params['locale'] == I18n.default_locale.to_s
    end

    def current_ability
      @current_ability ||= ::Ability.new(current_seller)
    end

    def get_index_data
      # toolbar data
      @categories = get_locale_categories
      @sellers = get_locale_sellers #.limit(8)
      @tags = get_locale_tags
      # main content data
      result_hash = ProductSql.get_products(params)
      @products = result_hash[:set]
      # pagination data
      @pages_urls = get_pages_urls(params['locale'], @namespace, request.query_parameters.to_query, params['page'].to_i, result_hash[:max_size])
      placeholder_images
    end

    def get_category_id
      # all_as_hash returns {"en"=>[["Category", 1]...], "fr"=>[["Catégorie", 1]...]}
      match = Category.all_as_hash[params['locale']].select { |cat| cat[0] == params['id'].capitalize }
      if match != []
        match[0][1]
      else
        "no match"
      end
    end
end