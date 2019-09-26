class Client < ApplicationRecord
  has_many :locations, as: :owner
  has_one :basket
  delegate :products, to: :basket, prefix: true

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable # , :confirmable

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [:name,  :stripped_email, [:name, :stripped_email]]
  end

  def stripped_email
    self.email.gsub(/@.*$/, "")
  end
end
