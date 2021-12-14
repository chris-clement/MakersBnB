feature 'can navigate to list space' do

  scenario 'can click button to go to list space' do
    visit '/makersbnb/homepage'
    click_button('List a Space')
    expect(page).to have_field('Name',placeholder: 'My Awesome Space')
  end
end