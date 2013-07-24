# PostalAddress

International postal address formatting

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

    PostalAddress.new(address).to_s
    
Set a home country (country names are not display for those addresses)

    PostalAddress.home_country = 'de'

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
