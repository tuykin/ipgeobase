class Ipgeobase::Weather
  autoload 'MetaWeather', 'ipgeobase/weather/meta_weather'
  autoload 'YahooWeather', 'ipgeobase/weather/yahoo_weather'

  attr_reader :service

  def self.build(service: nil)
    service ||= :metaweather
    new(service)
  end

  def initialize(service)
    @service = service
  end

  def weather_for(city, service = nil)
    if service.nil?
      service_class.weather_by_name(city)
    else
      services[service].weather_by_name(city)
    end
  end

  private

  def service_class
    services[service]
  end

  def services
    {
      metaweather: MetaWeather,
      yahooweather: YahooWeather
    }
  end
end