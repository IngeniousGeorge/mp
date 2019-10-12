 def sign_in_admin_user(
    email: email="admin@email.com",
    password: password="password")
  visit new_admin_user_session_path
  fill_in "admin_user_email", with: email
  fill_in "admin_user_password", with: password
  click_button "Login"
end