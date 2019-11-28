require "rails_helper"
require "helpers/seller_helper"

RSpec.describe "Seller -", type: :feature do

  xit "doesn't allow seller to delete last image" do
    set_seller_edit_context
    delete_seller_image

    expect(page).to have_text("You need at least one image")
  end

end