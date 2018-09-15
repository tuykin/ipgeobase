require "ipgeobase/version"
require "ipgeobase/misc"

module Ipgeobase
  autoload 'GeoObject', 'ipgeobase/geo_object'
  autoload 'Client', 'ipgeobase/client'
  autoload 'MetaWeather', 'ipgeobase/meta_weather'
  autoload 'YahooWeather', 'ipgeobase/yahoo_weather'

  def self.get(ip, client = nil)
    client ||= Client
    GeoObject.build(ip, client)
  end

  def self.weather_for(city)
    # MetaWeather.weather_by_name(city)
    YahooWeather.weather_by_name(city)
  end
end
