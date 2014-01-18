module Postal
  class Address
    Fields = [:recipient, :street, :zip, :state, :city, :country, :country_code]
  
    attr_accessor *Fields
  
    def initialize(attrs={})
      attrs.each do |attr, value|
        self.public_send("#{attr}=", value) if self.respond_to?("#{attr}=")
      end if attrs
    end
    
    def country_code=(code)
      @country_code = Postal.sanitize(code)
    end
    
    def country
      @country ||= Postal.country_names[country_code] unless in_home_country?
    end
    
    def in_home_country?
      Postal.home_country == country_code
    end

    def to_h
      attributes
    end
    
    def to_s
      AddressFormatter::Text.new(attributes).render
    end
        
    def to_html(params={})
      AddressFormatter::HTML.new(attributes).render(params)
    end
    
    private
    
    def attributes
      Fields.each_with_object({}) do |key, hash| 
        hash[key] = public_send(key)
      end
    end
  end
end