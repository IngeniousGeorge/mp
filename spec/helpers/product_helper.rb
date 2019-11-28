require "helpers/seller_helper" #sign_in_seller

# set up methods
  def set_create_context
    create(:category)
    seller = create(:seller)
    sign_in_seller
    # visit seller_dashboard_path("en", seller.slug)
  end

  def set_product_edit_context
    create(:category)
    product = build(:product)
    product_attach_images(product)
    product.save
    add_translation_to_product(product: product, description: "description en français")
    sign_in_seller
    # visit seller_dashboard_path("en", product.seller.slug)
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
    product.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.png'), filename: 'cover.png')
    product.images.attach(io: File.open('/home/ig/Code/mp/spec/files/test.png'), filename: 'test.png')
  end

# form methods
  def fill_in_create_form
    # click_button "New product"
    fill_in "product_name", with: "Product Name"
    fill_in "product_description", with: "Product description"
    fill_in "product_price", with: 1000
    fill_in "product_price_excl_vat", with: 800
  end

  # tags
    def create_with_two_tags
      within("#new_product") do 
        fill_in_create_form
        attach_required_images
        find("#new_product_en").set(true)
        fill_in "product_product_tags_attributes_1_tag", with: "Tag 1"
        fill_in "product_product_tags_attributes_2_tag", with: "Tag 2"
        click_button "Create"
      end
    end

  # translations
    def fill_in_translation_form
      find("#new_product_fr").set(true)
      find("#new_product_en").set(true)
      fill_in "product_product_translations_attributes_0_description", with: "description en français"
      fill_in "product_description", with: "english description"
    end

    def fill_in_translation_form_en_only
      # click_button "New product"
      find("#new_product_en").set(true)
      fill_in "product_description", with: "english description"
    end

    def edit_translation
      click_link "Products"
      click_link "Product Name"
      within("#product-name-seller-name") do
        find("#product_name_seller_name_fr").set(true)
        fill_in "product_product_translations_attributes_0_description", with: "edited description en français"
        click_button "Edit"
      end
    end

    def remove_translation
      click_link "Products"
      click_link "Product Name"
      within("#product-name-seller-name") do
        find("#product_name_seller_name_fr").set(false)
        click_button "Edit"
      end
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
        attach_file "product_images", "spec/files/test.png"
        fill_in_create_form
        click_button "Create"
      end
    end

    def add_product_without_image
      within("#new_product") do 
        attach_file "product_cover", "spec/files/test.png"
        fill_in_create_form
        click_button "Create"
      end
    end

    def change_product_cover
      within("#product_cover_product-name-seller-name") do 
        attach_file "product_cover", "spec/files/cover.png"
        click_button "Submit"
      end
    end

    def add_product_image
      within("#new_image_product-name-seller-name") do 
        attach_file "product_image", "spec/files/product.png"
        click_button "Submit"
      end
    end

    def delete_product_image
      within(".del_img") do 
        click_button "Delete"
      end
    end

    def attach_required_images
      attach_file "product_cover", "spec/files/test.png"
      attach_file "product_images", "spec/files/test.png"
    end

# return objects
  def last_created_product
    Product.order("created_at").last
  end

  def last_edited_product
    Product.order("updated_at").last
  end

  def last_edited_translation
    ProductTranslation.order("updated_at").last
  end

