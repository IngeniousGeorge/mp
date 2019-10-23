FactoryBot.define do
  factory :category_translation do
    category
    lang { "fr" }
    name { "Catégorie une" }
  end
end
