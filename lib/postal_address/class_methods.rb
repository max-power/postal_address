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
    
    def attributes
      @attributes ||= {}
    end

    private

    def attribute(name, params={})
      attributes[name] = params
      attr_reader name unless params[:reader] === false
      attr_writer name unless params[:writer] === false
      alias_attribute_writer(name, Array(params[:alias])) if params[:alias]
    end
    
    def alias_attribute_writer(original, aliases)
      aliases.each { |name| alias_method :"#{name}=", :"#{original}=" }
    end
  end
end