require "rails_helper"

RSpec.describe "I18n", type: :feature do

  it "can nest the current language in the URL" do
    visit "/fr/catalogue"

    expect(page.status_code).to eq 200
  end

  it "can translate strings with t(:something) method" do
    visit "/fr"
    # save_and_open_page
    # translation = find(:xpath, '//h1[1]').text

    expect(page).to have_text("Partenaires:")
  end

  xit "it can translate model attributes"

  xit "it can translate text from the DB"

  xit "it doesn't have any missing translations"

end