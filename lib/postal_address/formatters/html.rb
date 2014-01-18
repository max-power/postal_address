module Postal
  module AddressFormatter
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