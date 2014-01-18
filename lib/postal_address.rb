require "yaml"
require "postal_address/version"
require "postal_address/address"
require "postal_address/address_formatter"

module Postal
  class << self
    attr_accessor :home_country
    
    def home_country=(code)
      @home_country = sanitize(code)
    end

    def sanitize(code)
      code && code.to_s.downcase
    end
    
    def address_formats
      @address_formats ||= load_yaml('address_formats')
    end
  
    def country_names
      @country_names ||= load_yaml('country_names')
    end
    
    private
    
    def load_yaml(filename)
      YAML.load_file(File.expand_path("../data/#{filename}.yml", File.dirname(__FILE__)))
    end
  end
end
