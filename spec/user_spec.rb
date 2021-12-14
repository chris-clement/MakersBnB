require 'user'

describe User do
  describe '.valid' do
    it 'checks password and username is correct' do
      
      expect(User.valid("firstuser", "password")).to eq true
    end
  end

  describe '.all' do
    it 'returns all the users' do
      expect(User.all[0].username).to include "firstuser"
    end
  end
end