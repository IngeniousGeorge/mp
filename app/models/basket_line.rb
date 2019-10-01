class BasketLine < ApplicationRecord
  belongs_to :basket
  belongs_to :product

  private 
  
    def self.should_create?(params)
      false
    end
end
