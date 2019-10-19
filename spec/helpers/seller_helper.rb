#set up methods
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

  def add_translation_to_seller(seller:, description:)
    create(:seller_translation,
      id: "ecf71d9f-c738-40f3-996d-af0b23829151",
      lang: "fr",
      description: description,
      seller_id: seller.id)
  end

  def seller_attach_images(seller)
    seller.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.jpeg'), filename: 'cover.jpeg')
    seller.images.attach(io: File.open('/home/ig/Code/mp/spec/files/test.jpeg'), filename: 'test.jpeg')
  end

# form methods
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

  def edit_seller_translation
    within("#seller_edit") do
      fill_in "seller_seller_translations_attributes_0_Description", with: "edited description en français"
      click_button "Edit"
    end
  end

  def remove_translation
    within("#seller_edit") do
      find("#fr").set(false)
      click_button "Edit"
    end
  end

# return objects
  def last_edited_seller_translation
    SellerTranslation.order("updated_at").last
  end