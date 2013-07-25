require "yaml"

class PostalAddress
  module ClassMethods
    attr_reader :home_country
    
    def home_country=(code)
      @home_country = code && code.to_s.downcase
    end
    
    def formats
      @formats ||= load_yaml('address_formats')
    end
    
    def country_names
      @country_names ||= load_yaml('country_names')
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
    
    def load_yaml(filename)
      YAML.load_file(File.join(File.dirname(__FILE__), "..", "..", "data", "#{filename}.yml"))
    end
  end
end