FactoryBot.define do
  factory :product do
    seller
    name { "Product Name" }
    category { "Category" }
    description { "Product description" }
    price { 1000 }
    price_excl_vat { 800 }
    translations { "en|fr" }
  end
end
