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
      @address_formats ||= YAML.load_file(path_for(:address_formats), aliases: true)
    end
  
    def country_names
      @country_names ||= YAML.load_file(path_for(:country_names), aliases: true)
    end
    
    private
    
    def path_for(filename)
      Pathname.new(__FILE__).dirname.parent + "data" + "#{filename}.yml"
    end
  end
end
