feature 'we can view listings' do
  scenario 'should display a list of spaces' do
    visit ('/')
    expect(page).to have_content 'London Pad'
  end
end