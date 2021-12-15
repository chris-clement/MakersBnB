feature 'when a listing is created the user can view their listing' do
  scenario 'once submit is clicked the user is shown their listing' do
    create_listing('My space')
    expect(page).to have_content 'My space'
    expect(page).to have_content '100000'
    expect(page).to have_content 'A lovely space'
  end
end 