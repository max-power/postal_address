# -*- encoding: utf-8 -*-
require 'spec_helper'

describe PostalAddress do
  it "should load the formats" do
    PostalAddress.formats.wont_be :empty?
    PostalAddress.formats.must_be_kind_of Hash
  end
  
  it "should load the country_name" do
    PostalAddress.country_names.wont_be :empty?
    PostalAddress.country_names.must_be_kind_of Hash
  end
  
  it "should read/write home country" do
    PostalAddress.home_country = 'de'
    PostalAddress.home_country.must_equal 'de'    
  end
  
  it "should read/write home country and convert to string and lower case" do
    PostalAddress.home_country = :DE
    PostalAddress.home_country.must_equal 'de'
  end

  describe "Instance" do
    before {
      PostalAddress.home_country = nil
    }
     
    let(:address) do
      PostalAddress.new({
        recipient: 'Tobias Füncke', 
        street: '101 Broadway', 
        city: 'New York City', 
        zip: '10002', 
        state: 'NY', 
        country_code: 'us'
      })
    end
    
    it "should respond to to_h" do
      r = address.to_h
      r.must_be_kind_of Hash
      r.keys.length.must_equal 6
    end
    
    it "should format to US format" do
      address.to_s.must_equal "Tobias Füncke\n101 Broadway\nNew York City NY 10002\nUnited States of America"
    end
    
    it "should format to FR format" do
      address.country_code = 'fr'
      address.city = 'Paris'
      address.to_s.must_equal "Tobias Füncke\n101 Broadway\n10002 Paris\nFrance"
    end
    
    it "should format to DE format" do
      address.country_code = 'de'
      address.city = 'Berlin'
      address.to_s.must_equal "Tobias Füncke\n101 Broadway\n10002 Berlin\nGermany"
    end
    
    it "should not print the country if in home country" do
      PostalAddress.home_country = 'us'
      address.to_s.must_equal "Tobias Füncke\n101 Broadway\nNew York City NY 10002"
    end
    
    it "should print the country if not in home country" do
      PostalAddress.home_country = 'de'
      address.to_s.must_equal "Tobias Füncke\n101 Broadway\nNew York City NY 10002\nUnited States of America"
    end
    
    it "should use default formatting with state if format for country code is not available" do
      address.country_code = nil
      address.to_s.must_equal "Tobias Füncke\n101 Broadway\nNew York City NY 10002"
    end

    it "should use default formatting without state if format for country code is not available" do
      address.country_code = nil
      address.state = nil
      address.to_s.must_equal "Tobias Füncke\n101 Broadway\n10002 New York City"
    end
    
    it "should respond to state aliases" do
      [:region, :province, :territory, :administrative_area_level_1].each do |alias_name|
        address.must_respond_to alias_name
        address.must_respond_to :"#{alias_name}="
        address.send(alias_name).must_equal address.state
      end
    end
    
    it "should respond to city aliases" do
      [:locality].each do |alias_name|
        address.must_respond_to alias_name
        address.must_respond_to :"#{alias_name}="
        address.send(alias_name).must_equal address.city
      end
    end
    
    it "should respond to zip aliases" do
      [:zip_code, :postal_code, :postcode].each do |alias_name|
        address.must_respond_to alias_name
        address.must_respond_to :"#{alias_name}="
        address.send(alias_name).must_equal address.zip
      end
    end
  end
end