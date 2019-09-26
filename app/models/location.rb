class Location < ApplicationRecord
  belongs_to :owner, polymorphic: true

  extend FriendlyId
  friendly_id :name, use: :scoped, scope: :owner
end
