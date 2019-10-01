class BasketLinesController < ApplicationController
  before_action :set_basket_line

  # from checkout
  def update
    respond_to do |format|
      @basket_line.quantity += basket_line_params["quantity"].to_i
      if @basket_line.save
        format.html { redirect_back fallback_location: root_path, notice: "Product added" }
        format.json { render :show, status: :ok, location: @basket }
      else
        format.html { redirect_back fallback_location: root_path, alert: 'Product couldn\'t be added' }
        format.json { render json: @basket.errors, status: :unprocessable_entity }
      end
    end
  end

  # from products _card/show
  def create
    if @basket_line.quantity == nil
      @basket_line.quantity = basket_line_params["quantity"]

      respond_to do |format|
        if @basket_line.save
          format.html { redirect_back fallback_location: root_path, notice: "Product added" }
          format.json { render :show, status: :created, basket_line: @basket_line }
        else
          format.html { redirect_back fallback_location: root_path, alert: 'Product couldn\'t be added' }
          format.json { render json: @basket_line.errors, status: :unprocessable_entity }
        end
      end

    else
      respond_to do |format|
        @basket_line.quantity += basket_line_params["quantity"].to_i
        if @basket_line.save
          format.html { redirect_back fallback_location: root_path, notice: "Product added" }
          format.json { render :show, status: :ok, location: @basket }
        else
          format.html { redirect_back fallback_location: root_path, alert: 'Product couldn\'t be added' }
          format.json { render json: @basket.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private

    def set_basket_line
      @basket_line = BasketLine.find_or_initialize_by(basket_id: basket_line_params["basket_id"], product_id: basket_line_params["product_id"])
    end

    def basket_line_params
      params.require(:basket_line).permit(:product_id, :basket_id, :quantity)
    end
end
