FactoryBot.define do
  factory :product do
    name { "MyString" }
    slug { "MyString" }
    category { "MyString" }
    key_words { "MyText" }
    description { "MyText" }
    price { 1 }
    price_excl_vat { 1 }
    price_discount { 1 }
    seller_id { "" }
  end
end
