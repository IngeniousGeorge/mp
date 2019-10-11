class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :update, :destroy]
  before_action :set_redirect_path, only: [:create, :update, :destroy]
  # load_and_authorize_resource!!!

  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html do
          redirect_to @redirect_path, notice: 'Address was successfully created.'
        end
        format.json { render :show, status: :created, location: @location }
      else
        format.html { redirect_to @redirect_path, alert: 'Address couldn\'t be saved. ' + @location.errors[:coordinates].to_s }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @redirect_path, notice: 'Address was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { redirect_to @redirect_path, alert: 'Address couldn\'t be saved. '  + @location.errors[:coordinates].to_s }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to @redirect_path, notice: 'Address was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_location
    @location = Location.friendly.find(params[:id])
  end

  def location_params
    params.require(:location).permit(:name, :slug, :recipient, :street, :city, :state, :country, :postal_code, :delivery, :billing, :owner_type, :owner_id)
  end

  def set_redirect_path
    @redirect_path = case location_params["owner_type"]
      when "Seller" then seller_dashboard_path(owner_slug)
      when "Client" then client_dashboard_path(owner_slug)
      when "transporter" then transporter_dashboard_path(owner_slug)
      else root_path
    end
  end

  def owner_slug
    location_params["owner_type"].constantize.find(location_params["owner_id"]).slug
  end
  
end