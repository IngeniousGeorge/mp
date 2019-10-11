FactoryBot.define do

  factory :location do
    for_client # default trait if none is specified
    name { "Location Name" }
    recipient { "Client Recipient" }
    street { "Alexanderstraße 1" }
    city { "Berlin" }
    state { "Berlin" }
    country { "Deutschland" }
    postal_code { "10178" }

    trait :for_client do
      association :owner, factory: :client, name: "Client Location", email: "loc_email@email.com"
    end

    trait :for_seller do
      recipient { "Seller Recipient" }
      association :owner, factory: :seller, name: "Seller Location", slug: "seller-location", email: "loc_email@email.com"
    end
  end
end
