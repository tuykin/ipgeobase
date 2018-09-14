# IPGeobase

This gem is wrapper for geodata provided by [http://ipgeobase.ru/](http://ipgeobase.ru/).

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
