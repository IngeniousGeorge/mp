class LocationsController < ApplicationController

  def edit
    
  end

  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html do
          redirect_to seller_dashboard_path(params["seller_id"]), notice: 'Address was successfully created.'
        end
        format.json { render :show, status: :created, location: @location }
      else
        format.html { redirect_to seller_dashboard_path(params['seller_id']), alert: 'Address couldn\'t be saved' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location.owner, notice: 'Address was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def location_params
    params.require(:location).permit(:name, :slug, :recipient, :street, :city, :state, :country, :postal_code, :delivery, :billing, :owner_type, :owner_id)
  end

end