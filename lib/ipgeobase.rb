require "ipgeobase/version"
require "ipgeobase/misc"
require 'open_weather'

module Ipgeobase
  autoload 'GeoObject', 'ipgeobase/geo_object'
  autoload 'Client', 'ipgeobase/client'
  autoload 'MetaWeather', 'ipgeobase/meta_weather'

  def self.get(ip, client = nil)
    client ||= Client
    GeoObject.build(ip, client)
  end

  def self.weather_for(city)
    MetaWeather.weather_for(city)
  end
end
