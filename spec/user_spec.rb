# frozen_string_literal: true

require 'user'

describe User do
  describe '.valid' do
    it 'checks password and username is correct' do
      DatabaseConnection.query("INSERT INTO users(username, password) VALUES('firstuser', 'password');")
      user_password = User.valid('firstuser', 'password')
      expect(user_password).to eq true
    end

    it "returns false when username and password don't match" do
      DatabaseConnection.query("INSERT INTO users(username, password) VALUES('firstuser', 'password');")
      user_password = User.valid('firstuser', '123456')
      expect(user_password).to eq false
    end
  end

  describe '.create_user' do
    it 'stores user details into database' do
      result = User.create_user('firstuser' , 'password' , 'example@email.com' , 7123456789)
      expect(result[0]['username']).to eq 'firstuser'
      expect(result[0]['email']).to eq 'example@email.com'
    end
  end
end
