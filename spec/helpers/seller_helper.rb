def sign_in_seller
  visit new_seller_session_path
  fill_in "seller_email", with: "seller@email.com"
  fill_in "seller_password", with: "password"
  click_button "Sign in"
end

def set_seller_edit_context
  seller = build(:seller)
  seller.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.jpeg'), filename: 'cover.jpeg')
  seller.images.attach(io: File.open('/home/ig/Code/mp/spec/files/test.jpeg'), filename: 'test.jpeg')
  seller.save
  sign_in_seller
  visit seller_dashboard_path("en", seller.slug)
end

def change_seller_cover
  within("#seller_cover_seller-name") do 
    attach_file "seller_cover", "spec/files/test2.png"
    click_button "Submit"
  end
end