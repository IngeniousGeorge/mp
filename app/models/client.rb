class Client < ApplicationRecord
  has_many :locations, as: :owner
  has_one :basket
  delegate :products, to: :basket, prefix: true

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable # , :confirmable

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    %i[name email]
  end
end
