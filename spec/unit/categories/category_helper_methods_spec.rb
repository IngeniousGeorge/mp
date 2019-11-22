require "rails_helper"
require "helpers/admin_user_helper"

RSpec.describe "Category - ", type: :feature do

  context "category helper methods - " do

    before do
      create(:category_translation) #creates category
      Categorize.define_all_as_hash
    end

    it "the method is available at init" do
      expect(Category.all_as_hash['en'][0][0]).to eq('Category one')
      expect(Category.all_as_hash['fr'][0][0]).to eq('Catégorie une')
    end

    it "creates the helper method after save" do
      cat = create(:category, name: "Category two")
      create(:category_translation, name: "Catégorie deux", category: cat)
      
      expect(Category.all_as_hash['en'][1][0]).to eq('Category two')
      expect(Category.all_as_hash['fr'][1][0]).to eq('Catégorie deux')
    end
  end
end