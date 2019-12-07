FactoryBot.define do
  factory :client do
    name { "Client" }
    email { "client@email.com" }
    password { "password" }
    basket
  end
end
