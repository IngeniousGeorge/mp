# set up methods
  def sign_in_admin_user(
      email: email="admin@example.com",
      password: password="password")
    visit new_admin_user_session_path
    fill_in "admin_user_email", with: email
    fill_in "admin_user_password", with: password
    click_button "Login"
end

# form methods

  def fill_in_seller(
    name: name="Seller",
    slug: slug="seller",
    email: email="seller@email.com",
    description: description="Seller description",
    translations: translations="en",
    button_text:)
    fill_in "seller_name", with: name
    fill_in "seller_slug", with: slug
    fill_in "seller_email", with: email
    fill_in "seller_password", with: "password"
    fill_in "seller_description", with: description
    fill_in "seller_translations", with: translations
    click_button button_text
  end

  def create_category_with_translation(name: name="Category", lang: lang="fr", translation: translation="Catégorie")
    click_link "Add New Category translation"
    within("#new_category") do
      fill_in "category_name", with: name
      fill_in "category[category_translations_attributes][0][lang]", with: lang
      fill_in "category[category_translations_attributes][0][name]", with: translation
      click_button "Create Category"
    end
  end

  def edit_category_with_translation(name: name="Category", lang: lang="fr", translation: translation="Catégorie")
    within("#edit_category") do
      fill_in "category_name", with: name
      fill_in "category[category_translations_attributes][0][lang]", with: lang
      fill_in "category[category_translations_attributes][0][name]", with: translation
      click_button "Update Category"
    end
  end

  def delete_category
    within("#collection_selection") do
      click_link "Delete"
    end
  end

# return objects methods

  def last_created_category
    Category.order("created_at").last
  end

  def last_created_category_translation
    CategoryTranslation.order("created_at").last
  end

  def last_edited_category
    Category.order("updated_at").last
  end

  def last_edited_category_translation
    CategoryTranslation.order("updated_at").last
  end