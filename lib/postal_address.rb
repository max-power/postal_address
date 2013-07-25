require "postal_address/version"
require "postal_address/class_methods"
require "postal_address/instance_methods"

class PostalAddress
  extend ClassMethods
  include InstanceMethods
  
  # define the postal address attributes and aliases for easier assignment
  attribute :recipient,    itemprop: 'name'
  attribute :street,       itemprop: 'streetAddress',   alias: [:street_address]
  attribute :zip,          itemprop: 'postalCode',      alias: [:zip_code, :postal_code, :postcode]
  attribute :state,        itemprop: 'addressRegion',   alias: [:region, :province, :territory, :administrative_area_level_1]
  attribute :city,         itemprop: 'addressLocality', alias: [:locality]
  attribute :country_code, itemprop: 'addressCountry',  alias: [:country_id], writer: false
  attribute :country,      itemprop: 'addressCountry',  writer: false, reader: false
end
