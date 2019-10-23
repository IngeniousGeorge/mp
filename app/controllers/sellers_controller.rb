class SellersController < ApplicationController
  before_action :set_seller, only: [:show, :update, :update_cover, :attach_image, :delete_image]
  before_action :translate_seller, only: [:show]
  before_action :placeholder_images, only: [:show]
  before_action :authenticate_seller!, only: [:update, :update_cover, :attach_image, :delete_image]
  # load_and_authorize_resource :seller, find_by: :slug

  def show
  end

  def index
    @sellers = Seller.all
  end

  def update
    respond_to do |format|
      if @seller.update(seller_params)
        format.html { redirect_to seller_dashboard_path(@seller), notice: 'Seller was successfully updated.' }
        format.json { render :show, status: :ok, location: @seller }
      else
        format.html { render seller_dashboard_path(@seller), alert: 'Seller wasn\'t successfully updated.' }
        format.json { render json: @seller.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_cover
    respond_to do |format|
      if @seller.cover = params[:seller][:cover]
        format.html do
          redirect_to seller_dashboard_path(@seller), notice: 'Cover was successfully updated.'
        end
        format.json { render :show, status: :updated, location: @seller }
      else
        format.html { redirect_to seller_dashboard_path(@seller), alert: "Cover wasn't successfully updated" }
        format.json { render json: @seller.errors, status: :unprocessable_entity }
      end
    end
  end

  def attach_image
    respond_to do |format|
      if @seller.images.attach(params[:seller][:image])
        format.html do
          redirect_to seller_dashboard_path(@seller), notice: 'Image was successfully added.'
        end
        format.json { render :show, status: :updated, location: @seller }
      else
        format.html { redirect_to seller_dashboard_path(@seller), alert: "Image wasn't successfully added." }
        format.json { render json: @seller.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete_image
    if @seller.images.count <= 1 
      redirect_to seller_dashboard_path(@seller), notice: 'You need at least one image'
    else
      image = ActiveStorage::Attachment.find(params[:seller][:image_id])
      respond_to do |format|
        if image.purge
          format.html do
            redirect_to seller_dashboard_path(@seller), notice: 'Image was successfully deleted.'
          end
          format.json { render :show, status: :updated, location: @seller }
        else
          format.html { redirect_to seller_dashboard_path(@seller), alert: "Image wasn't successfully deleted." }
          format.json { render json: @seller.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private

    def set_seller
      @seller = Seller.friendly.find(params[:id])
    end

    def seller_params
      params.require(:seller).permit(:email, :password, :name, :slug, :description, :translations, :cover, images: [], seller_translations_attributes: [:id, :lang, :description, :seller_id])
    end

    def translate_seller
      @seller = @seller.translate_object(params['locale']) unless params['locale'] == I18n.default_locale
    end

    def placeholder_images
      @seller.set_cover_placeholder unless @seller.cover.attached?
      @seller.set_images_placeholder unless @seller.images.attached?    
    end

    def current_ability
      @current_ability ||= ::Ability.new(current_seller)
    end
end
