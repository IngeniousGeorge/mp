class Ability
  include CanCan::Ability

  # def initialize(seller)
  #   can [:index, :show], [Seller, Product]
  #   if seller.present?
  #     can :manage, [Seller, Product], id: seller.slug
  #     can :read, :dashboard, id: seller.slug
  #   end
  # end

  # def initialize(client)
  #   can :read, [Seller, Product, Basket]
  #   if client.present?
  #     can :manage, [Client, Basket], id: client.id 
  #     can :read, :dashboard, id: client.id
  #   end
  # end
end
