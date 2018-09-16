require 'ostruct'
require 'webmock/rspec'

describe Ipgeobase::Weather do
  describe 'initialize' do
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

    it do
      service = Ipgeobase::Weather.new(:custom_provider, { custom_provider: CustomProvider })
      obj = service.weather_for('The City')
      expect(obj.location).to eq('The City')
    end
  end

  describe '#weather_for' do
    describe 'metaweather (by default)' do
      let(:location_name) { 'london' }
      let(:location_id) { '44418' }

      it do
        stub_request(:get, "https://www.metaweather.com/api/location/#{location_id}/")
          .to_return(body: load_fixture('meta_weather_location.json'))
        stub_request(:get, "https://www.metaweather.com/api/location/search/?query=#{location_name}")
          .to_return(body: load_fixture('meta_weather_location_search.json'))

        service = Ipgeobase::Weather.build
        obj = service.weather_for(location_name)
        expect(obj.location).to eq('London')
        expect(obj.date).to eq(Date.parse('2018-09-15'))
        expect(obj.weather_state).to eq('Heavy Cloud')
        expect(obj.temp_min).to eq(12)
        expect(obj.temp_max).to eq(20)
        expect(obj.pressure).to eq(1027)
        expect(obj.humidity).to eq(63)
        expect(obj.visibility).to eq(11)
      end
    end

    describe 'yahoo weather api' do
      let(:location_name) { 'london' }

      it do
        stub_request(:get, "http://query.yahooapis.com/v1/public/yql")
          .with(query: hash_including(:q))
          .to_return(body: load_fixture('yahoo_weather.json'))

        service = Ipgeobase::Weather.build(:yahooweather)
        obj = service.weather_for(location_name)
        expect(obj.location).to eq('Nice')
        expect(obj.date).to eq(Date.parse('2016-08-17'))
        expect(obj.weather_state).to eq('Thunderstorms')
        expect(obj.temp_min).to eq(20)
        expect(obj.temp_max).to eq(26)
        expect(obj.pressure).to eq(33627)
        expect(obj.humidity).to eq(75)
        expect(obj.visibility).to eq(25)
      end
    end
  end
end