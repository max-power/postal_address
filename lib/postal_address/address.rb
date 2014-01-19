module Postal
  class Address
    Fields = [:recipient, :street, :zip, :state, :city, :country, :country_code]
  
    attr_accessor *Fields
    
    alias_method :locality=,    :city=
    alias_method :zip_code=,    :zip=
    alias_method :postal_code=, :zip=
    alias_method :postcode=,    :zip=
    alias_method :region=,      :state=
    alias_method :province=,    :state=
    alias_method :territory=,   :state=
    alias_method :administrative_area_level_1=, :state=
        
    def country_code=(code)
      @country_code = Postal.sanitize(code)
    end
    
    def country
      @country ||= Postal.country_names[country_code]
    end
  
    def initialize(attrs={})
      attrs.each do |field, value|
        self.public_send(:"#{field}=", value) if self.respond_to?(:"#{field}=")
      end if attrs
    end
    
    def to_h
      Fields.each_with_object({}) { |field, hash| hash[field] = public_send(field) }
    end

    def to_s
      AddressFormatter::Text.new(to_h).render
    end
        
    def to_html(params={})
      AddressFormatter::HTML.new(to_h).render(params)
    end
  end
end