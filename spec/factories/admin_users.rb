FactoryBot.define do
  factory :admin_user do
    email { "admin@email.com" }
    password { "password" }
    confirmed_at { Date.yesterday }
  end
end
