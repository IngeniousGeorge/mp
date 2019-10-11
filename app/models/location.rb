class Location < ApplicationRecord
  belongs_to :owner, polymorphic: true

  after_validation :geocode

  extend FriendlyId
  friendly_id :name, use: :scoped, scope: :owner

  geocoded_by :address

  def address
    [street, city, state, country].compact.join(', ')
  end
end
