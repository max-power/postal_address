require "yaml"

class PostalAddress
  module ClassMethods
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
end