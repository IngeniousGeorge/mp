require "rails_helper"
require "helpers/admin_user_helper"

RSpec.describe "Category - ", type: :feature do

  context "category helper methods - " do

    before do
      create(:category_translation) #creates category
      require 'categorize'
      Categorize.define_all_as_hash
    end

    it "the method is available at init" do
      expect(Category.all_as_hash['en']).to eq(['Category one'])
      expect(Category.all_as_hash['fr']).to eq(['Catégorie une'])
    end

    it "creates the helper method after save" do
      create(:category, id: 9, name: "Category two")
      create(:category_translation, lang: "fr", name: "Catégorie deux", category_id: 9)
      
      expect(Category.all_as_hash['en'][1]).to eq('Category two')
      expect(Category.all_as_hash['fr'][1]).to eq('Catégorie deux')
    end

  end
end