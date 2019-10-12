def sign_up_client(
    name: name="Client Name",
    email: email="client@email.com",
    password: password="password")
  visit new_client_registration_path
  within("#new_client") do
    fill_in "client_name", with: name
    fill_in "client_email", with: "client@email.com"
    fill_in "client_password", with: password
    fill_in "client_password_confirmation", with: password
  end
  click_button "Sign up"
end

def sign_in_client(
    email: email="client@email.com",
    password: password="password")
  visit new_client_session_path
  fill_in "client_email", with: email
  fill_in "client_password", with: password
  click_button "Sign in"
end