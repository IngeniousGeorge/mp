class BasketLine < ApplicationRecord
  belongs_to :basket
  belongs_to :product
  before_save :delete_if_null

  def add_to_line(quantity)
    self.quantity += quantity
  end

  def set_absolute_value(quantity)
    self.quantity = quantity
  end

  private 

    def delete_if_null
      
    end

end
