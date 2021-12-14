# frozen_string_literal: true

feature 'we can log in' do
  scenario 'log in with username and password' do
    visit('/')
    click_on 'login'
    expect(page).to have_content 'Welcome to MakersBnB'
  end
end

feature 'fill out log in form' do
  scenario 'fill out log in form with username and password' do
    visit('/')
    click_on 'login'
    fill_in 'username', with: 'firstuser'
    fill_in 'password', with: 'password'
    click_on 'login'
    expect(page).to have_content 'firstuser'
  end
end
