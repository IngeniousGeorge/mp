class Location < ApplicationRecord
  belongs_to :owner, polymorphic: true
end
