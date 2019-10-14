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

def update_client(
    name: name="Client name",
    email: email="client@email.com",
    password: password="password")
  within("#update_client") do
    fill_in "client_name", with: name
    fill_in "client_email", with: email
    click_button
  end
end

def log_out_client
  click_link "Log out"
end

def last_created_client
  Client.order("created_at").last
end
