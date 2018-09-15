require "ipgeobase/version"
require "ipgeobase/sample"
require "ipgeobase/ext_enum"
require "ipgeobase/array"
require "ipgeobase/string"

module Ipgeobase
  autoload 'GeoObject', 'ipgeobase/geo_object'

  def self.get(ip)
    GeoObject.build(ip)
  end

  def self.main
    files = Dir.glob("*")

    res = files
          .reject { |f| f.start_with?('.') }
          .sort
          .middle
          .plural('s')
          .upcase

    puts res
    res
  end
end
