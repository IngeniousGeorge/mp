class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :update_cover, :attach_image, :delete_image, :destroy]
  before_action :set_redirect_path, only: [:create, :update, :update_cover, :attach_image, :delete_image, :destroy]
  before_action :translate_product, only: [:show]
  load_and_authorize_resource :seller, find_by: :slug, only: [:create, :update, :update_cover, :attach_image, :delete_image, :destroy]

  def index
    @products = set_products
    p @products.inspect
  end

  def index_seller
    @seller = Seller.friendly.find(params['id'])
    @products = @seller.products
    render "index"
  end

  def index_cat
    @products = Product.where(category: params['id'])
    render "index"
  end

  def index_loc
    render "index"
  end

  def index_tag
    @products = Product.find_by_tag(params['id'])
    render "index"
  end

  def show
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

  def set_products
    if params['locale'] == I18n.default_locale.to_s
      @products = Product.all
    else
      @products = Product.all.map { |p| p.translate_object(params['locale']) }
      # @products = Product.all.translate_collection(params['locale'])
    end
  end
    
  def product_params
    params.require(:product).permit(:id, :name, :slug, :category, :description, :price, :price_excl_vat, :price_discount, :price_discount_excl_vat, :seller_id, :cover, images: [], product_tags_attributes: [:id, :tag, :product_id, :_destroy])
  end

  def set_redirect_path
    @redirect_path = seller_dashboard_path(params["seller_id"])
  end

  def translate_product
    @product = @product.translate_object(params['locale']) unless params['locale'] == I18n.default_locale
  end

  def current_ability
    @current_ability ||= ::Ability.new(current_seller)
  end
end
