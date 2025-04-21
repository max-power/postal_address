require 'json'

module Postal
  module AddressFormatter
    class JsonLD
      attr_reader :address

      def initialize(address)
        @address = address
      end

      def render(**)
        address_as_json.reject { |k,v| v.nil? || v.empty? }.to_json
      end
      
      private
      
      def address_as_json
        {
          "@context"        => "https://schema.org",
          "@type"           => "PostalAddress",
          "streetAddress"   => @address[:street],
          "addressLocality" => @address[:city],
          "addressRegion"   => @address[:state],
          "postalCode"      => @address[:zip],
          "addressCountry"  => @address[:country_code]
        }
      end     
    end
  end
end
