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
        @address
      end

      def address_format
        Postal.address_formats[@address[:country_code]] || Postal.address_formats[@address[:state] ? 'us' : 'de']
      end
    end

    
    class HTML < Text
      Schema   = 'http://schema.org/PostalAddress'
      ItemProp = {
        recipient: 'name',
        street:    'streetAddress',
        zip:       'postalCode',
        state:     'addressRegion',
        city:      'addressLocality',
        country:   'addressCountry'
      }
  
      def render(params={})
        content_tag((params.delete(:tag) || :p), super.gsub("\n", "<br>"), params.merge(itemscope: nil, itemtype: Schema))
      end
  
      private
  
      def address_data
        super.each_with_object({}) do |(key, value), hash|
          hash[key] = content_tag(:span, value, itemprop: ItemProp[key])
        end
      end
  
      def content_tag(tag, content='', attributes={})
        attrs = attributes.map {|k,v| k.to_s + (v ? "=\"#{v}\"" : '') }.unshift('').join(' ')
        "<#{tag}#{attrs}>#{content}</#{tag}>"
      end
    end
  end
end