feature 'it allows user to view listings' do
  scenario 'on the homepage the user can see all listings' do
    MakersBnb_Listings.create_space(space_name:"test_space_1", price:"1", description:"this is a space", user_id: 1)
    MakersBnb_Listings.create_space(space_name:"test_space_2", price:"1", description:"this is a space", user_id: 1)
    MakersBnb_Listings.create_space(space_name:"test_space_3", price:"1", description:"this is a space", user_id: 1)
    login_and_visit_home
    expect(page).to have_content "test_space_2"
    expect(page).to have_content "test_space_3"
  end
end