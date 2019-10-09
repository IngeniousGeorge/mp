FactoryBot.define do

  factory :location do
    for_client # default trait if none is specified
    name { "Office" }
    recipient { "Joe" }
    street { "15 rue des Chenes" }
    city { "Montbert" }
    state { "Loire-Atlantique" }
    country { "France" }
    postal_code { "44140" }

    trait :for_client do
      association :owner, factory: :client, name: "Joe Loc", email: "loc_email@mp.com"
    end

    trait :for_seller do
      recipient { "Jim" }
      association :owner, factory: :seller, name: "Jim Loc", email: "loc_email@mp.com"
    end
  end
end
