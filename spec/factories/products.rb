FactoryBot.define do
  factory :product do
    seller
    name { "Chocolate" }
    category { "Food" }
    description { "Some description" }
    price { 1000 }
    price_excl_vat { 8000 }
    
    # factory :same_name_different_seller do
    #   association :seller, factory: :seller, name: "Other", email: "other@mp.com"
    # end
  end
end
