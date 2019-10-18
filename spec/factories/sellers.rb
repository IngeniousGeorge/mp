FactoryBot.define do
  factory :seller do
    name { "Seller Name" }
    email { "seller@email.com" }
    password { "password" }
    description { "Seller description" }
  end
end
