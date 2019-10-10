FactoryBot.define do
  factory :product do
    seller
    name { "Chocolate" }
    slug { "chocolate" }
    category { "Food" }
    description { "Some description" }
    price { 1000 }
    price_excl_vat { 8000 }

    # trait :for_seller do
    #   recipient { "Jim" }
    #   association :owner, factory: :seller, name: "Jim Loc", email: "loc_email@mp.com"
    # end
  end
end
