require "postal_address/version"
require "postal_address/class_methods"
require "postal_address/instance_methods"

class PostalAddress
  extend ClassMethods
  include InstanceMethods

  # define the postal address attributes and aliases for easier assignment
  # attribute(name, alias1, alias2, ...)
  attribute :recipient
  attribute :street,       :street_address
  attribute :zip,          :zip_code, :postal_code, :postcode
  attribute :state,        :region, :province, :territory, :administrative_area_level_1
  attribute :city,         :locality
  attribute :country_code, :country_id   # expects ISO 3166 Alpha 2 codes
end