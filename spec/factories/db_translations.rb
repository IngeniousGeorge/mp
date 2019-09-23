FactoryBot.define do
  factory :db_translation do
    parent_class { "MyString" }
    parent_id { "" }
    parent_atr { "MyString" }
    lang { "MyString" }
    translation { "MyText" }
  end
end
