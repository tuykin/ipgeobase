require 'optparse'
require 'ipgeobase/weather'

class Ipgeobase::CLI
  def self.start
    options = {}

    OptionParser.new do |opts|
      opts.banner = 'Usage: exe/weather [options] city'

      opts.on("--service SERVICE_NAME",
          "The name of weather service. Use one of: #{Ipgeobase::Weather.service_providers.keys.join(', ')}") do |v|
        options[:service] = v
      end
    end.parse!

    city = ARGV.first
    if city.nil? || city.empty?
      puts 'city parameter should be added'
      exit(-1)
    end
    service = Ipgeobase::Weather.build(options[:service].to_sym)
    weather = service.weather_for(city)
    puts stringify(weather)
  end

  def self.stringify(weather)
    return 'city not found' if weather.empty?
    <<-eos
      Weather in #{weather.location} for #{weather.date}:
      #{weather.weather_state}, temp: #{weather.temp_min} - #{weather.temp_max},
      Pressure: #{weather.pressure}, humidity: #{weather.humidity}, visibility: #{weather.visibility}.
      Have a nice day!
    eos
  end
end