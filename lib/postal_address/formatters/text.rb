module Postal
  module AddressFormatter
    class Text
      attr_reader :address
      # expects any hash with the 7 keys from Postal::Address::Fields
      def initialize(address)
        @address = address
      end
  
      def render(params={})
        (address_format % address_data).strip
      end

      private
  
      def address_data
        address[:country] = nil if home_country?
        address
      end

      def address_format
        Postal.address_formats.fetch(address[:country_code]) { default_address_format }
      end
      
      def default_address_format
        Postal.address_formats[address[:state] ? 'us' : 'de']
      end
      
      def home_country?
        Postal.home_country == address[:country_code]
      end
    end
  end
end
