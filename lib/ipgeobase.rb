require "ipgeobase/version"
require 'ipgeobase/geo_object'
require 'ipgeobase/client'
require "ipgeobase/misc"

module Ipgeobase
  # autoload 'GeoObject', 'ipgeobase/geo_object'
  # autoload 'Client', 'ipgeobase/client'

  def get_location(ip)
    GeoObject.build(ip, Client)
  end
end
