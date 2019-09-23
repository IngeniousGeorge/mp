FactoryBot.define do
  factory :location do
    name { "MyString" }
    street { "MyText" }
    city { "MyString" }
    state { "MyString" }
    country { "MyString" }
    postal_code { "MyString" }
    lat { 1.5 }
    lon { 1.5 }
  end
end
