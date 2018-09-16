class Ipgeobase::Weather
  autoload 'MetaWeather', 'ipgeobase/weather/meta_weather'
  autoload 'YahooWeather', 'ipgeobase/weather/yahoo_weather'

  DEFAULT_SERVICE_PROVIDER_KEY = :metaweather
  BASE_SERVICES = {
      metaweather: MetaWeather,
      yahooweather: YahooWeather
    }.freeze

  def self.build(service_provider = DEFAULT_SERVICE_PROVIDER_KEY)
    new(service_provider)
  end

  def initialize(service_provider_key, custom_services = {})
    @service_providers = BASE_SERVICES.merge(custom_services)
    @default_service_provider_key = service_provider_key
    @services = {}

    add_service(@default_service_provider_key)
  end

  def weather_for(city, service_provider_key = nil)
    services(service_provider_key).weather_by_name(city)
  end

  def services(service_provider_key = nil)
    key = service_provider_key || @default_service_provider_key
    @services[key] ||= add_service(key)
  end

  def service_providers
    @service_providers
  end

  def self.service_providers
    BASE_SERVICES
  end

  private

  def add_service(service_provider_key)
    @services[service_provider_key] = service_providers[service_provider_key].new
  end
end