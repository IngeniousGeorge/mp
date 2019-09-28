class LocationsController < ApplicationController

  def edit
    
  end

  def create
    @location = Location.new(location_params)
    redirect_path = owner_redirect_path(@location.owner_type, @location.owner.slug)

    respond_to do |format|
      if @location.save
        format.html do
          redirect_to redirect_path, notice: 'Address was successfully created.'
        end
        format.json { render :show, status: :created, location: @location }
      else
        format.html { redirect_to redirect_path, alert: 'Address couldn\'t be saved' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to redirect_path, notice: 'Address was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render redirect_path, alert: 'Address couldn\'t be saved' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def location_params
    params.require(:location).permit(:name, :slug, :recipient, :street, :city, :state, :country, :postal_code, :delivery, :billing, :owner_type, :owner_id)
  end

  def owner_redirect_path(owner_type, slug)
    case owner_type
    when "Seller" then seller_dashboard_path(slug)
    when "Client" then client_dashboard_path(slug)
    when "transporter" then transporter_dashboard_path(slug)
    else root_path
    end
  end
  
end