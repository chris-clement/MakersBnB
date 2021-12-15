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
end
