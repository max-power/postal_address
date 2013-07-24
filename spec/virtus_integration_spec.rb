require 'spec_helper'
require 'virtus'

class Address
  include Virtus
  attribute :id,           Integer
  attribute :recipient,    String
  attribute :street,       String
  attribute :zip,          String
  attribute :city,         String
  attribute :state,        String
  attribute :country_code, String
  attribute :geolocation,  Array
  
  def postal_address
    PostalAddress.new(self.attributes).to_s
  end
end

describe Address do
  let(:address) {
    Address.new({
      id: 1001,
      recipient: 'Tobias Füncke', 
      street: '101 Broadway', 
      city: 'New York City', 
      zip: '10002', 
      state: 'NY', 
      country_code: 'us',
      geolocation: [13,52]
    })
  }
  
  it "should work" do
    PostalAddress.home_country = 'us'
    address.postal_address.must_equal "Tobias Füncke\n101 Broadway\nNew York City NY 10002"
  end
end