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
  end
end