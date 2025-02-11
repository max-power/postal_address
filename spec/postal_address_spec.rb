# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Postal do
  it "should load the formats" do
    skip
    _(Postal.address_formats).wont_be :empty?
    _(Postal.address_formats).must_be_kind_of Hash
  end
  
  it "should load the country_name" do
    skip
    _(Postal.country_names).wont_be :empty?
    _(Postal.country_names).must_be_kind_of Hash
  end
  
  it "should read/write home country" do
    Postal.home_country = :de
    _(Postal.home_country).must_equal :de
  end
  
  it "should sanititze home country" do
    Postal.home_country = 'DE'
    _(Postal.home_country).must_equal :de
  end

  describe "Instance" do
    before {
      Postal.home_country = nil
    }
     
    let(:address) do
      Postal::Address.new({
        recipient: 'Tobias Füncke', 
        street: '101 Broadway', 
        city: 'New York City', 
        postcode: '10002', 
        state: 'NY', 
        country_code: 'us'
      })
    end
    
    it "should respond to to_h" do
      r = address.to_h
      _(respond).must_be_kind_of Hash
      _(respond).keys.length.must_equal 7
    end
    
    it "should format to US format" do
      _(address.to_s).must_equal "Tobias Füncke\n101 Broadway\nNew York City NY 10002\nUnited States of America"
    end
    
    it "should format to FR format" do
      address.country_code = 'fr'
      address.city = 'Paris'
      _(address.to_s).must_equal "Tobias Füncke\n101 Broadway\n10002 Paris\nFrance"
    end
    
    it "should format to DE format" do
      address.country_code = 'de'
      address.city = 'Berlin'
      _(address.to_s).must_equal "Tobias Füncke\n101 Broadway\n10002 Berlin\nGermany"
    end
    
    it "should not print the country if in home country" do
      Postal.home_country = 'us'
      _(address.to_s).must_equal "Tobias Füncke\n101 Broadway\nNew York City NY 10002"
    end
    
    it "should print the country if not in home country" do
      Postal.home_country = 'de'
      _(address.to_s).must_equal "Tobias Füncke\n101 Broadway\nNew York City NY 10002\nUnited States of America"
    end
    
    it "should use default formatting with state if format for country code is not available" do
      address.country_code = nil
      _(address.to_s).must_equal "Tobias Füncke\n101 Broadway\nNew York City NY 10002"
    end

    it "should use default formatting without state if format for country code is not available" do
      address.country_code = nil
      address.state = nil
      _(address.to_s).must_equal "Tobias Füncke\n101 Broadway\n10002 New York City"
    end
    
    it "should return html" do
      _(address.to_html).must_equal "<p itemscope itemtype=\"http://schema.org/PostalAddress\"><span itemprop=\"name\">Tobias Füncke</span><br><span itemprop=\"streetAddress\">101 Broadway</span><br><span itemprop=\"addressLocality\">New York City</span> <span itemprop=\"addressRegion\">NY</span> <span itemprop=\"postalCode\">10002</span><br><span itemprop=\"addressCountry\">United States of America</span></p>"
    end
    
    it "should return html with default formatting" do
      address.country_code = nil
      address.state = nil
      _(address.to_html).must_equal "<p itemscope itemtype=\"http://schema.org/PostalAddress\"><span itemprop=\"name\">Tobias Füncke</span><br><span itemprop=\"streetAddress\">101 Broadway</span><br><span itemprop=\"postalCode\">10002</span> <span itemprop=\"addressLocality\">New York City</span></p>"
    end
    
    it "should return custom html" do
      _(address.to_html(tag: :section, itemprop: 'address')).must_equal "<section itemprop=\"address\" itemscope itemtype=\"http://schema.org/PostalAddress\"><span itemprop=\"name\">Tobias Füncke</span><br><span itemprop=\"streetAddress\">101 Broadway</span><br><span itemprop=\"addressLocality\">New York City</span> <span itemprop=\"addressRegion\">NY</span> <span itemprop=\"postalCode\">10002</span><br><span itemprop=\"addressCountry\">United States of America</span></section>"
    end

  end
end