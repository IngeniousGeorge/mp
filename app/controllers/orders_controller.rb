class OrdersController < ApplicationController

  def create
    p "here"
    order = Order.new(order_params)
    p order
    redirect_to root_path, notice: 'Order was successfully registered'
  end

  private

    def order_params
      params.require(:order).permit(:id, :client_id, :amount, order_sales_attributes: [:id, :seller_id, :amount, :order_id], order_products_attributes: [:id, :product_id, :quantity, :order_sale_id, :order_id])
    end
end