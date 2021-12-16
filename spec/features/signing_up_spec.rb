feature 'A user can sign up' do
  scenario 'A user completes a sign up form' do
    visit '/'
    click_on 'Sign Up'
    fill_in 'username', with: 'firstuser'
    fill_in 'password', with: 'password'
    fill_in 'email', with: 'example@gmail.com'
    fill_in 'phone_number', with: 1234567
    click_on 'Submit'
    expect(page).to have_content 'Thanks for signing up to MakersBnB'
  end
end