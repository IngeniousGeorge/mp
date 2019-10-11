class Location < ApplicationRecord
  belongs_to :owner, polymorphic: true

  before_validation :purge_coordinates
  after_validation :geocode

  extend FriendlyId
  friendly_id :name, use: :scoped, scope: :owner

  geocoded_by :address

  def address
    [street, city, state, country].compact.join(', ')
  end

  def purge_coordinates
    self.latitude = nil
    self.longitude = nil
  end

  def geocode
    super
    if self.latitude.blank? || self.longitude.blank?
      self.errors[:coordinates] << "Address couldn't be recognized, please try again"
    end
  end
end
