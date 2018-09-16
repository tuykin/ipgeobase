# IPGeobase

This gem is wrapper for geodata provided by [http://ipgeobase.ru/](http://ipgeobase.ru/).

ipgeobase service provides xml-based answers. You can try it with curl:

```(bash)
curl http://ipgeobase.ru:7020/geo?ip=178.204.73.174
```

```(xml)
<?xml version="1.0"?>
<ip-answer>
  <ip value="178.204.73.174">
    <inetnum>178.204.0.0 - 178.207.255.255</inetnum>
    <country>RU</country>
    <city>Казань</city>
    <region>Республика Татарстан</region>
    <district>Приволжский федеральный округ</district>
    <lat>55.796539</lat>
    <lng>49.108200</lng>
  </ip>
</ip-answer>
```

Service doesn't provide proper HTTP codes. It responses with 200 everytime with custom messages:

```(bash)
curl http://ipgeobase.ru:7020/geo?ip=qwerty
```

```(xml)
<?xml version="1.0"?>
<ip-answer>
  <message>Incorrect request</message>
</ip-answer>
```

```(bash)
curl http://ipgeobase.ru:7020/geo?ip=134.234.3.2
```

```(xml)
<?xml version="1.0"?>
<ip-answer>
  <ip value="134.234.3.2">
    <message>Not found</message>
  </ip>
</ip-answer>
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ipgeobase'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ipgeobase

## Usage

To create new geo object simply call

```ruby
Ipgeobase.get('178.204.73.174')
# =>
# <Ipgeobase::GeoObject
#   @city="Казань",
#   @country="RU",
#   @district="Приволжский федеральный округ",
#   @inetnum="178.204.0.0 - 178.207.255.255",
#   @ip="178.204.73.174",
#   @latitude="55.796539",
#   @longtitude="49.108200",
#   @region="Республика Татарстан">
```

### Weather tool

To user cli just run
```(bash)
exe/weather --service metaweather berlin
```

To use Ipgeobase::Weather class:
```(ruby)
service = Ipgeobase::Weather.build(service: <service name>)
weather = service.weather_for('berlin')

# <service_name>:
#   - :yahooweather
#   - :metaweather
```

If you want to use your custom provider:
```(ruby)

# custom provider should satisfy interface below:
# have methods:
# - weather_by_name(location_name)
# return:
# - location:String
# - date:Date
# - weather_state:String
# - temp_min:Integer
# - temp_max:Integer
# - pressure:Integer
# - humidity:Integer
# - visibility:Integer

class CustomProvider
  def weather_by_name(location_name)
    OpenStruct.new(
      {
        location: location_name,
        date: Date.new,
        weather_state: 'Sunny',
        temp_min: 23,
        temp_max: 25,
        pressure: 768,
        humidity: 75,
        visibility: 100
      }
    )
  end
end

# Usage
service = Ipgeobase::Weather.new(:custom_provider, { custom_provider: CustomProvider })
obj = service.weather_for('The City')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tuykin/ipgeobase.
