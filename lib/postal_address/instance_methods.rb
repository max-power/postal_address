class PostalAddress
  module InstanceMethods
    def initialize(params={})
      params.each do |attr, value|
        self.public_send("#{attr}=", value) if self.respond_to?("#{attr}=")
      end if params
    end

    def to_h
      attributes
    end

    def to_s
      format(attributes)
    end

    def to_html(params={})
      address = format(attributes(:html)).gsub("\n", "<br>")
      content_tag((params.delete(:tag) || :p), address, params.merge(itemscope: nil, itemtype: 'http://schema.org/PostalAddress'))
    end

    def country_code=(code)
      @country_code = code && code.to_s.downcase
    end

    def country
      @country = self.class.country_names[country_code] unless in_home_country?
    end

    private

    def format(hash)
      (address_format % hash).strip
    end

    def address_format
      self.class.formats[country_code] || self.class.formats[state ? 'us' : 'de']
    end

    def in_home_country?
      self.class.home_country == country_code
    end

    def attributes(html=false)
      self.class.attributes.inject({}) do |hash, (key, attribute)|
        value = public_send(key)
        value = value && content_tag(:span, value, itemprop: attribute[:itemprop]) if html
        hash[key] = value
        hash
      end
    end

    def content_tag(tag, content='', attributes={})
      attrs = attributes.map {|k,v| k.to_s + (v ? "=\"#{v}\"" : '') }.unshift('').join(' ')
      "<#{tag}#{attrs}>#{content}</#{tag}>"
    end
  end
end
