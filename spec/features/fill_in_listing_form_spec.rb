require_relative 'listing_web_helper'

feature 'filling in form' do

  scenario 'user can fill in form' do
    create_listing('My space')
  end

  scenario 'once completed, a pop up will state the listing has been created ' do
    create_listing('My second space')
    expect(page).to have_content("Listing Successful")
  end
  
  scenario 'can not name a space if that name already exists' do
    create_listing('My second space')
    create_listing('My second space')
    expect(page).to have_content("Listing unsucessful")
  end
end