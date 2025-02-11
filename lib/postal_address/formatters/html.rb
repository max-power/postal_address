module Postal
  module AddressFormatter
    class HTML < Text
      ItemType = 'http://schema.org/PostalAddress'
      ItemProp = {
        recipient: 'name',
        street:    'streetAddress',
        zip:       'postalCode',
        state:     'addressRegion',
        city:      'addressLocality',
        country:   'addressCountry'
      }

      def render(**params)
        tagname = params.delete(:tag) || :p
        content = super.gsub("\n", "<br>")
        tag tagname, content, **params.merge(itemscope: nil, itemtype: ItemType)
      end

      private

      def address_data
        super.map do |key, value|
          [key, tag_for(key, value)]
        end.to_h
      end
      
      def tag_for(key, value)
        tag :span, value, itemprop: ItemProp[key] if value
      end

      def tag(name, content='', **attrs)
        "<#{name}#{tag_attributes(attrs)}>#{content}</#{name}>"
      end
  
      def tag_attributes(attrs)
        attrs.map { |k,v| v.nil? ? k : %[#{k}="#{v}"] }.unshift('').join(' ')
      end
    end
  end
end
