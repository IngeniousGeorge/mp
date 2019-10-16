FactoryBot.define do
  factory :db_translation do
    parent_class { "Product" }
    parent_id { "" }
    parent_atr { "Name" }
    lang { "fr" }
    translation { "Traduction" }
  end
end
