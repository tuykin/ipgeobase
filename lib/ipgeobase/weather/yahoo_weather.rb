require 'ostruct'
require 'weather-api'

class Ipgeobase::Weather::YahooWeather
  def self.weather_by_name(location_name)
    response = Weather.lookup_by_location(location_name, Weather::Units::CELSIUS)
    map_weather(response)
  end

  private

  def self.map_weather(response)
    OpenStruct.new(
        {
          date: response.forecasts[0].date.to_date,
          weather_state: response.forecasts[0].text,
          temp_min: response.forecasts[0].low,
          temp_max: response.forecasts[0].high,
          pressure: response.atmosphere.pressure.round,
          humidity: response.atmosphere.humidity,
          visibility: response.atmosphere.visibility
        }
      )
  end
end