require 'ostruct'
require 'webmock/rspec'

class Ipgeobase::ClientStub
  def self.get_response(ip)
    OpenStruct.new(body: load_fixture('ipgeobase.xml'))
  end
end

describe Ipgeobase do
  describe '.get' do
    subject { Ipgeobase.get(ip, Ipgeobase::ClientStub) }

    context 'ip is valid' do
      let(:ip) { '178.204.73.174' }

      it { expect(subject.ip).to eq(ip) }
      it do
        is_expected.to have_attributes(
            city: 'Казань',
            country: 'RU',
            district: 'Приволжский федеральный округ',
            inetnum: '178.204.0.0 - 178.207.255.255',
            latitude: '55.796539',
            longtitude: '49.108200',
            region: 'Республика Татарстан'
          )
      end
    end

    context 'ip is invalid' do
      let(:ip) { 'qwerty' }

      it { expect(subject.ip).to eq(nil) }
      it { expect(subject.city).to eq(nil) }
    end

    # context 'ip is not found' do
    #   let(:ip) { '134.234.3.2' }

    #   it { expect(subject.ip).to eq(ip) }
    #   it { expect(subject.city).to eq(nil) }
    # end
  end

  describe '.weather_for' do
    describe 'metaweather' do
      let(:location_name) { 'london' }
      let(:location_id) { '44418' }

      xit do
        stub_request(:get, "https://www.metaweather.com/api/location/#{location_id}/")
          .to_return(body: load_fixture('meta_weather_location.json'))
        stub_request(:get, "https://www.metaweather.com/api/location/search/?query=#{location_name}")
          .to_return(body: load_fixture('meta_weather_location_search.json'))

        obj = Ipgeobase.weather_for(location_name)
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

        obj = Ipgeobase.weather_for(location_name)
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