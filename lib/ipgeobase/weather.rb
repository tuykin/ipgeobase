class Ipgeobase::Weather
  autoload 'MetaWeather', 'ipgeobase/weather/meta_weather'
  autoload 'YahooWeather', 'ipgeobase/weather/yahoo_weather'
  BASE_SERVICES = {
      metaweather: MetaWeather,
      yahooweather: YahooWeather
    }.freeze

  def self.build(service_provider = :metaweather)
    new(service_provider)
  end

  def initialize(service_provider, custom_services = {})
    @services = BASE_SERVICES.merge(custom_services)
    @service_obj = services[service_provider].new
  end

  def weather_for(city, service_provider = nil)
    return @service_obj.weather_by_name(city) if service_provider.nil?
    services[service_provider].new.weather_by_name(city)
  end

  def services
    @services
  end

  def self.services
    BASE_SERVICES
  end
end