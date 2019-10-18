require "rails_helper"
require "helpers/product_helper"

RSpec.describe "I18n", type: :feature do

  it "can nest the current language in the URL" do
    visit "/fr/catalogue"

    expect(page.status_code).to eq(200)
  end

  it "can translate strings with t(:something) method" do
    visit "/fr"

    expect(page).to have_text("Partenaires")
  end

  xit "doesn't have any missing translations"

end