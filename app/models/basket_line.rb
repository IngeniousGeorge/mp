class BasketLine < ApplicationRecord
  belongs_to :basket
  belongs_to :product
  after_save :delete_if_null

  delegate :client, to: :basket

  def add_to_line(quantity)
    self.quantity += quantity
  end

  def set_absolute_value(quantity)
    self.quantity = quantity
  end

  private 

    def delete_if_null
      self.destroy if self.quantity <= 0
    end

end
