FactoryBot.define do
  factory :product_tag do
    product
    tag { "Tag" }
    product_id { "" }
  end
end
