class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]
  before_action :set_redirect_path, only: [:create, :update, :destroy, :delete_logo, :delete_images]
  load_and_authorize_resource :seller, find_by: :slug, only: [:create, :update, :destroy]

  def index
    @products = Product.all
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
    @products = Product.find_by_sql(["SELECT * FROM products WHERE id IN (SELECT product_id FROM product_tags WHERE tag LIKE ?)", params['id']])
    render "index"
  end

  def show
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
        format.html { redirect_to @redirect_path, alert: "Product wasn't successfully created" }
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

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to @redirect_path, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def delete_logo
    @logo = ActiveStorage::Attachment.find(Product.friendly.find(params[:id]).logo.id)
    @logo.purge
    redirect_to @redirect_path
  end

  def delete_images
    Product.friendly.find(params[:id]).images.each do |i|
      @image = ActiveStorage::Attachment.find(Product.friendly.find(params[:id]).images.first.id)
      @image.purge
    end
    redirect_to @redirect_path
  end

  private

  def set_product
    @product = Product.friendly.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:id, :name, :slug, :category, :description, :price, :price_excl_vat, :price_discount, :price_discount_excl_vat, :seller_id, :logo, images: [], product_tags_attributes: [:id, :tag, :product_id, :_destroy])
  end

  def set_redirect_path
    @redirect_path = seller_dashboard_path(params["seller_id"])
  end

  def current_ability
    @current_ability ||= ::Ability.new(current_seller)
  end
end
