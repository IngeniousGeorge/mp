class BasketLinesController < ApplicationController
  before_action :set_basket_line
  before_action :set_quantity

  # from account/checkout
  def update
    if params['commit'] == "Change" || params['commit'] == "Modifier"
      respond_to do |format|
        @basket_line.set_absolute_value(@quantity)
        if @basket_line.save
          format.html { redirect_back fallback_location: root_path, notice: "Quantity was edited successfully" }
          format.json { render :show, status: :ok, location: @basket }
        else
          format.html { redirect_back fallback_location: root_path, alert: "Quantity couldn't be edited" }
          format.json { render json: @basket.errors, status: :unprocessable_entity }
        end
      end

    elsif params['commit'] == "Remove" || params['commit'] == "Supprimer"
      @basket_line.destroy
      respond_to do |format|
        format.html { redirect_back fallback_location: root_path, notice: "Product was successfully removed." }
        format.json { head :no_content }
      end
    end
  end

  # from products _card/show
  # first checking if the product chosen was already in the client's basket
  def create
    if @basket_line.quantity == nil 
      
      @basket_line.set_absolute_value(@quantity)
      respond_to do |format|
        if @basket_line.save
          format.html { redirect_back fallback_location: root_path, notice: "Product added" }
          format.json { render :show, status: :created, basket_line: @basket_line }
        else
          format.html { redirect_back fallback_location: root_path, alert: "Product couldn't be added" }
          format.json { render json: @basket_line.errors, status: :unprocessable_entity }
        end
      end

    else
      respond_to do |format|
        @basket_line.add_to_line(@quantity)
        if @basket_line.save
          format.html { redirect_back fallback_location: root_path, notice: "Product added" }
          format.json { render :show, status: :ok, location: @basket }
        else
          format.html { redirect_back fallback_location: root_path, alert: "Product couldn't be added" }
          format.json { render json: @basket.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private

    def set_basket_line
      @basket_line = BasketLine.find_or_initialize_by(basket_id: basket_line_params["basket_id"], product_id: basket_line_params["product_id"])
    end

    def set_quantity
      @quantity = basket_line_params["quantity"].to_i
    end

    def basket_line_params
      params.require(:basket_line).permit(:product_id, :basket_id, :quantity)
    end
end
