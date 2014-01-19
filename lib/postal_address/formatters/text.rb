module Postal
  module AddressFormatter
    class Text
      # expects any hash with the fields names of address
      def initialize(address)
        @address = address
      end
  
      def render(params={})
        (address_format % address_data).strip
      end

      private
  
      def address_data
        @address[:country] = nil if Postal.home_country? @address[:country_code]
        @address
      end

      def address_format
        Postal.address_formats[@address[:country_code]] || default_address_format
      end
      
      def default_address_format
        Postal.address_formats[@address[:state] ? 'us' : 'de']
      end
    end
  end
end