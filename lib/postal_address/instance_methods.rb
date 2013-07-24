class PostalAddress
  module InstanceMethods
    def initialize(attributes={})
      attributes.each do |attr, value|
        self.public_send("#{attr}=", value) if self.respond_to?("#{attr}=")
      end if attributes
    end

    def to_s
      (format % to_h).strip
    end

    def to_h
      { :recipient=>recipient, :street=>street, :zip=>zip, :city=>city, :state=>state, :country=>country }
    end
    
    def to_html(tag=:div, attributes={})
      html_hash = {
        recipient: recipient && span_tag(recipient, 'name'),
        street:    street && span_tag(street, 'streetAddress'),
        zip:       zip && span_tag(zip, 'postalCode'),
        city:      city && span_tag(city, 'addressLocality'),
        state:     state && span_tag(state, 'addressRegion'),
        country:   country && span_tag(country, 'addressCountry')
      }
      html = (format % html_hash).strip.gsub("\n", "<br>")
      content_tag(tag, html, {itemscope: nil, itemtype: 'http://schema.org/PostalAddress'}.merge(attributes))
    end

    def country_code=(code)
      @country_code = code && code.to_s.downcase
    end

    def country
       self.class.country_names[country_code] unless in_home_country?
    end

    private

    def format
      self.class.formats[country_code] || self.class.formats[state ? 'us' : 'de']
    end

    def in_home_country?
      self.class.home_country == country_code
    end
    
    def span_tag(content, itemprop)
      content_tag(:span, content, itemprop: itemprop)
    end
  
    def content_tag(tag, content='', attributes={})
      attrs = attributes.map {|k,v| k.to_s + (v ? "=\"#{v}\"" : '') }.unshift('').join(' ')
      "<#{tag}#{attrs}>#{content}</#{tag}>"
    end
  end
end