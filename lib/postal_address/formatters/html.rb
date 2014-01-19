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
          hash[key] = value && content_tag(:span, value, itemprop: ItemProp[key])
        end
      end

      def content_tag(tag, content='', attrs={})
        "<#{tag}#{tag_attributes(attrs)}>#{content}</#{tag}>"
      end
      
      def tag_attributes(attrs)
        attrs.map { |k,v| v ? %[#{k}="#{v}"] : k }.unshift('').join(' ')
      end
    end
  end
end