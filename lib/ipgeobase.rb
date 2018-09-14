require "ipgeobase/version"
require "ipgeobase/sample"
require "ipgeobase/geo_object"

module Ipgeobase
  def self.get(ip)
    GeoObject.build(ip)
  end
end
