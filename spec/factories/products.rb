FactoryBot.define do
  factory :product do
    seller
    name { "Product Name" }
    category { "b98ef0f1-5eb3-4e13-984a-49814638ff52" }
    description { "Product description" }
    price { 1000 }
    price_excl_vat { 800 }
    translations { "en|fr" }
  end
end
