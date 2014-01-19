# International Postal Address Formatting 

International postal address formatting with HTML Microformats.

[![Build Status](https://travis-ci.org/max-power/postal_address.png)](https://travis-ci.org/max-power/postal_address)

## Installation

Add this line to your application's Gemfile:

    gem 'postal_address'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install postal_address

## Usage

    address = {
      recipient: 'Tobias Füncke', 
      street: '101 Broadway', 
      city: 'New York City', 
      zip: '10002', 
      state: 'NY', 
      country_code: 'us'
    }

    Postal::Address.new(address).to_s
     
    Tobias Füncke
    101 Broadway
    New York City NY 10002
    United States of America
      
    Postal::Address.new(address).to_html
    
    <p itemscope itemtype="http://schema.org/PostalAddress">
      <span itemprop="name">Tobias Füncke</span>
      <br>
      <span itemprop="streetAddress">101 Broadway</span>
      <br>
      <span itemprop="addressLocality">New York City</span>
      <span itemprop="addressRegion">NY</span>
      <span itemprop="postalCode">10002</span>
      <br>
      <span itemprop="addressCountry">United States of America</span>
    </p>
    
    
Set a home country (country names are not display for those addresses)

    Postal.home_country = 'us'
    
    p = Postal::Address.new(address)
    p.to_html(tag: 'section', itemprop: 'address')

    <section itemprop="address" itemscope itemtype="http://schema.org/PostalAddress">
      <span itemprop="name">Tobias Füncke</span>
      <br>
      <span itemprop="streetAddress">101 Broadway</span>
      <br>
      <span itemprop="addressLocality">New York City</span>
      <span itemprop="addressRegion">NY</span>
      <span itemprop="postalCode">10002</span>
    </section>
    
    
Standalone AddressFormatter usage:

    Postal::AddressFormatter::Text.new(address).render
    
    Postal::AddressFormatter::HTML.new(address).render(tag: 'section', itemprop: 'address')


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
