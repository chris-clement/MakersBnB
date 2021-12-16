# frozen_string_literal: true

feature 'we can view listings' do
  scenario 'should display a list of spaces' do
    MakersBnb_Listings.create_space(space_name:"London Pad", price:"1", description:"this is a space", user_id: 1)
    visit('/')
    expect(page).to have_content 'London Pad'
  end
end
