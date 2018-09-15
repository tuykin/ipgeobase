require "ipgeobase/version"
require "ipgeobase/misc"

module Ipgeobase
  autoload 'GeoObject', 'ipgeobase/geo_object'
  autoload 'Client', 'ipgeobase/client'
  autoload 'Weather', 'ipgeobase/weather'

  def self.get(ip, client = nil)
    client ||= Client
    GeoObject.build(ip, client)
  end
end
