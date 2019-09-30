class BasketLine < ApplicationRecord
  belongs_to :basket

  private 
  
    def self.should_create?(params)
      false
    end
end
