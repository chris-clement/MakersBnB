require 'images'

describe Images do
  describe '.save_url' do
    it 'store url into the array' do
      Images.save_url('London Flat', 'http://images.jpg')
      expect(Images::URL).to eq {'London Flat' => 'http://images.jpg'}
    end
  end

  describe '.url_by_space' do
    it 'retrieve url by space name' do
      Images.save_url('London Flat', 'http://images.jpg')
      expect(Images.url_by_space('London Flat')).to eq 'http://images.jpg'
    end
  end
end