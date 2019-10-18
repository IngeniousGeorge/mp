require "helpers/seller_helper" #sign_in_seller

def set_create_context
  create(:category)
  seller = create(:seller)
  sign_in_seller
  visit seller_dashboard_path("en", seller.slug)
end

def set_product_edit_context
  product = build(:product)
  product_attach_images(product)
  product.save
  sign_in_seller
  visit seller_dashboard_path("en", product.seller.slug)
end

def return_product_with_purged_image
  product = build(:product)
  product_attach_images(product)
  product.save
  product.cover.purge
  product.images.purge
  return product
end

def create_valid_product(attributes = {}, seller = nil)
  product = seller ? build(:product, seller: seller) : build(:product)
  product_attach_images(product)
  product.assign_attributes(attributes) if attributes != {}
  product.save
  return product
end

def add_translation_to_product(product:, description:)
  create(:product_translation,
    id: "ecf71d9f-c738-40f3-996d-af0b23829151",
    lang: "fr",
    description: description,
    product_id: product.id)
end

def product_attach_images(product)
  product.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.jpeg'), filename: 'cover.jpeg')
  product.images.attach(io: File.open('/home/ig/Code/mp/spec/files/test.jpeg'), filename: 'test.jpeg')
end


def create_with_two_tags
  within("#new_product") do 
    fill_in_create_form
    attach_required_images
    fill_in "product_product_tags_attributes_1_tag", with: "Tag 1"
    fill_in "product_product_tags_attributes_2_tag", with: "Tag 2"
    click_button "Create"
  end
end

def fill_in_create_form
  fill_in "product_name", with: "Product Name"
  fill_in "product_description", with: "Product description"
  fill_in "product_price", with: 1000
  fill_in "product_price_excl_vat", with: 800
end

def fill_in_translation_form
  fill_in "product_product_translations_attributes_0_description", with: "description en français"
  fill_in "product_translations", with: "en|fr"
end

#images
def add_product_with_cover_and_image
  within("#new_product") do 
    attach_required_images
    fill_in_create_form
    click_button "Create"
  end
end

def add_product_without_cover
  within("#new_product") do 
    attach_file "product_images", "spec/files/test.jpeg"
    fill_in_create_form
    click_button "Create"
  end
end

def add_product_without_image
  within("#new_product") do 
    attach_file "product_cover", "spec/files/test.jpeg"
    fill_in_create_form
    click_button "Create"
  end
end

def change_product_cover
  within("#product_cover_product-name-seller-name") do 
    attach_file "product_cover", "spec/files/test2.png"
    click_button "Submit"
  end
end

def add_product_image
  within("#new_image_product-name-seller-name") do 
    attach_file "product_image", "spec/files/test2.png"
    click_button "Submit"
  end
end

def delete_product_image
  within(".del_img") do 
    click_button "Delete"
  end
end

def attach_required_images
  attach_file "product_cover", "spec/files/test.jpeg"
  attach_file "product_images", "spec/files/test.jpeg"
end

def last_created_product
  Product.order("created_at").last
end

