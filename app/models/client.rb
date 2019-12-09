class Client < ApplicationRecord
  has_many :locations, as: :owner
  has_many :orders
  has_many :order_lines
  has_many :sales
  has_one :basket
  delegate :lines, :id, to: :basket, prefix: true

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
