FactoryBot.define do
  factory :product do
    seller
    name { "Chocolate" }
    slug { "chocolate" }
    category { "Food" }
    description { "Some description" }
    price { 1000 }
    price_excl_vat { 8000 }
  end
end
