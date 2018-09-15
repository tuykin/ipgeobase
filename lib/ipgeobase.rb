require "ipgeobase/version"
require "ipgeobase/misc"

module Ipgeobase
  autoload 'GeoObject', 'ipgeobase/geo_object'

  def self.get(ip)
    GeoObject.build(ip)
  end
end
