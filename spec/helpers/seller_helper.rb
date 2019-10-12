def sign_in_seller(
    email: email="seller@email.com",
    password: password="password")
  visit new_seller_session_path
  fill_in "seller_email", with: email
  fill_in "seller_password", with: password
  click_button "Sign in"
end

def set_seller_edit_context
  seller = build(:seller)
  seller_attach_images(seller)
  seller.save
  sign_in_seller
  visit seller_dashboard_path("en", seller.slug)
end

def return_seller_with_purged_image
  seller = build(:seller)
  seller_attach_images(seller)
  seller.save
  seller.cover.purge
  seller.images.purge
  return seller
end

def seller_attach_images(seller)
  seller.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.jpeg'), filename: 'cover.jpeg')
  seller.images.attach(io: File.open('/home/ig/Code/mp/spec/files/test.jpeg'), filename: 'test.jpeg')
end

def change_seller_cover
  within("#seller_cover_seller-name") do 
    attach_file "seller_cover", "spec/files/test2.png"
    click_button "Submit"
  end
end

def add_seller_image
  within("#new_image_seller-name") do 
    attach_file "seller_image", "spec/files/test2.png"
    click_button "Submit"
  end
end

def delete_seller_image
  within(first ".del_img") do 
    click_button "Delete"
  end
end