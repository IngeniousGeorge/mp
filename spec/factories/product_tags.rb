FactoryBot.define do
  factory :product_tag do
    product
    lang { "en" }
    tag { "Tag" }
    product_id { "" }
  end
end
