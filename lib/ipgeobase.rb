require "ipgeobase/version"
require "ipgeobase/sample"
require "ipgeobase/geo_object"
require "ipgeobase/ext_enum"
require "ipgeobase/array"
require "ipgeobase/string"

module Ipgeobase
  def self.get(ip)
    GeoObject.build(ip)
  end

  def self.main
    files = Dir.glob("*")

    res = files
            .select { |f| !f.start_with?('.') }
            .sort
            .middle
            .plural('s')
            .upcase

    puts res
    res
  end


end
