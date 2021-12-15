def create_listing(name) 
  visit '/makersbnb/list_a_space'
  fill_in('Name',with: name)
  fill_in('Price',with: '100000')
  fill_in('Description',with: 'A lovely space')
  click_on 'Submit'
end 