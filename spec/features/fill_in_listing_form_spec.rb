require_relative 'listing_web_helper'

feature 'filling in form' do

  scenario 'user can fill in form' do
    login_and_visit_home
    create_listing('My space')
  end

  scenario 'once completed, a pop up will state the listing has been created ' do
    login_and_visit_home
    create_listing('My second space')
    expect(page).to have_content("Listing created")
  end
  
  scenario 'can not name a space if that name already exists' do
    login_and_visit_home
    create_listing('My second space')
    create_listing('My second space')
    expect(page).to have_content("Listing unsucessful")
  end
end