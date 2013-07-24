require "postal_address/version"
require "yaml"

class PostalAddress
  class << self
    attr_reader :home_country
    
    def home_country=(code)
      @home_country = code && code.to_s.downcase
    end
        
    def formats
      @formats ||= YAML.load_file("data/address_formats.yml")
    end
  
    def country_names
      @country_names ||= YAML.load_file("data/country_names.yml")
    end
    
    private
    
    def attribute(name, *aliases)
      attr_accessor name
      aliases.each { |a| define_attribute_alias(a, name) }
    end
    
    def define_attribute_alias(new_name, original)
      alias_method new_name, original
      alias_method :"#{new_name}=", :"#{original}="
    end
  end

  # define the postal address attributes and aliases for easier assignment
  attribute :recipient
  attribute :street,       :street_address
  attribute :zip,          :zip_code, :postal_code, :postcode
  attribute :state,        :region, :province, :territory, :administrative_area_level_1
  attribute :city,         :locality
  attribute :country_code, :country_id   # expects ISO 3166 Alpha 2 codes

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