FactoryBot.define do
  factory :product_translation do
    product
    lang { "fr" }
    description { "Description du produit" }
  end
end
