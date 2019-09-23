class Client < ApplicationRecord
  has_one :basket
  has_many :client_locations
  delegate :products, to: :basket, prefix: true

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable # , :confirmable

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    %i[name email]
  end
end
