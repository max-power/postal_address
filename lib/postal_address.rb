require "yaml"
require "pathname"
require "postal_address/version"
require "postal_address/address"
require "postal_address/formatters/text"
require "postal_address/formatters/html"

module Postal
  class << self
    attr_reader :home_country
    
    def home_country=(code)
      @home_country = sanitize(code)
    end

    def sanitize(code)
      code && code.to_s.downcase
    end
    
    def address_formats
      @address_formats ||= YAML.load_file(pathname(:address_formats))
    end
  
    def country_names
      @country_names ||= YAML.load_file(pathname(:country_names))
    end
    
    private
    
    def pathname(filename)
      Pathname.new(__FILE__).dirname.join("..", "data", "#{filename}.yml")
    end
  end
end
