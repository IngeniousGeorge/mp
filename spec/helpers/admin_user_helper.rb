def sign_in_admin_user(
    email: email="admin@example.com",
    password: password="password")
  visit new_admin_user_session_path
  fill_in "admin_user_email", with: email
  fill_in "admin_user_password", with: password
  click_button "Login"
end

def fill_in_seller(
  name: name="Seller",
  slug: slug="seller",
  email: email="seller@email.com",
  description: description="Seller description",
  categories: categories="['food']",
  translations: translations="en",
  button_text:)
  fill_in "seller_name", with: name
  fill_in "seller_slug", with: slug
  fill_in "seller_email", with: email
  fill_in "seller_password", with: "password"
  fill_in "seller_description", with: description
  fill_in "seller_categories", with: categories
  fill_in "seller_translations", with: translations
  click_button button_text
end