module Postal
  class Address
    Fields = %i(recipient street zip state city country country_code).freeze
  
    attr_accessor(*Fields)

    def initialize(**attrs, &block)
      attrs.each { |k,v| public_send("#{k}=", v) if respond_to?("#{k}=") }
      yield self if block_given?
    end

    def country_code=(code)
      @country_code = Postal.sanitize(code)
    end
    
    def country
      Postal.country_names[country_code]
    end
  
    def values
      Fields.map(&method(:public_send))
    end
    
    def to_h
      Fields.zip(values).to_h
    end

    def to_s(**)
      AddressFormatter::Text.new(to_h).render(**)
    end
        
    def to_html(**)
      AddressFormatter::HTML.new(to_h).render(**)
    end
    
    def to_json_ld(**)
      AddressFormatter::JsonLD.new(to_h).render(**)
    end
  end
end