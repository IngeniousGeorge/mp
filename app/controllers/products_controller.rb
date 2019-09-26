class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update]
  load_and_authorize_resource :seller, :find_by => :slug, only: [:new, :create, :edit, :update, :destroy]

  def index
    # @products = Seller.friendly.find(params[:seller_id]).products
    @products = Product.all
  end

  def index_seller
    seller_id = Seller.where(slug: params['id']).take.id
    @products = Product.where(seller_id: seller_id)
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
    @products = Product.find_by_sql(["SELECT * FROM products WHERE ? = ANY (key_words)", params['id']])
    render "index"
  end

  def new
    @seller_id = Seller.friendly.find(params[:seller_id]).id
    @product = Product.new()
  end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html do
          redirect_to new_seller_product_path(params["seller_id"]), notice: 'Product was successfully created.'
        end
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @product
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_product
    @product = Product.friendly.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :category, :key_words, :description, :price, :seller_id)
  end

  def current_ability
    @current_ability ||= ::Ability.new(current_seller)
  end
end
