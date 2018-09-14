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
    <city>&#x41A;&#x430;&#x437;&#x430;&#x43D;&#x44C;</city>
    <region>&#x420;&#x435;&#x441;&#x43F;&#x443;&#x431;&#x43B;&#x438;&#x43A;&#x430; &#x422;&#x430;&#x442;&#x430;&#x440;&#x441;&#x442;&#x430;&#x43D;</region>
    <district>&#x41F;&#x440;&#x438;&#x432;&#x43E;&#x43B;&#x436;&#x441;&#x43A;&#x438;&#x439; &#x444;&#x435;&#x434;&#x435;&#x440;&#x430;&#x43B;&#x44C;&#x43D;&#x44B;&#x439; &#x43E;&#x43A;&#x440;&#x443;&#x433;</district>
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
Ipgeobase::GeoObject.build(ip)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tuykin/ipgeobase.
