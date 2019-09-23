require "rails_helper"

RSpec.describe "I18n", type: :feature do

  it "can nest the current language in the URL" do
    visit "/en/home/index"

    expect(page.status_code).to eq 200
  end

  xit "can translate to the current language" do

  end

end