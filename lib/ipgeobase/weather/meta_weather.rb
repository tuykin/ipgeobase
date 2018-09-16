require 'ostruct'
require 'net/http'
require 'uri'
require 'json'

class Ipgeobase::Weather::MetaWeather
  URL = "https://www.metaweather.com/api"

  def self.weather_by_name(location_name)
    location = search_for_location(location_name)
    return {} if location.empty?
    weather_by_id(location.woeid)
  end

  private

  def self.weather_by_id(location_id)
    uri = URI.parse("#{URL}/location/#{location_id}/")
    response = Net::HTTP.get_response(uri)
    response_hash = JSON.parse(response.body)
    map_weather(response_hash)
  end

  def self.search_for_location(query)
    uri = URI.parse("#{URL}/location/search/?query=#{query}")
    response = Net::HTTP.get_response(uri)
    response_hash = JSON.parse(response.body)
    map_location(response_hash)
  end

  def self.map_weather(response_hash)
    item = response_hash['consolidated_weather'][0]
    OpenStruct.new(
        {
          location: response_hash['title'],
          date: Date.parse(item['applicable_date']),
          weather_state: item['weather_state_name'],
          temp_min: item['min_temp'].round,
          temp_max: item['max_temp'].round,
          pressure: item['air_pressure'].round,
          humidity: item['humidity'].round,
          visibility: item['visibility'].round
        }
      )
  end

  def self.map_location(response_hash)
    item = response_hash[0]
    return {} if item.nil?
    OpenStruct.new(item)
  end
end