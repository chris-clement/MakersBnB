def go_to_login_page
  visit('/')
  click_on('Login')
end

def login_and_visit_home
  DatabaseConnection.query("INSERT INTO users(username, password) VALUES('firstuser', 'password');")
  go_to_login_page
  fill_in('username', with: 'firstuser')
  fill_in('password', with: 'password')
  click_on('Login')
end

def today_date
  Time.now.strftime("%d-%m-%Y")
end
