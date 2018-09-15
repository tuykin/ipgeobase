class Ipgeobase::ClientStub
  def self.get_response(ip)
    load_fixture('ipgeobase.xml')
  end
end

describe Ipgeobase do
  describe '.get' do
    subject { Ipgeobase.get_location(ip, Ipgeobase::ClientStub) }

    context 'ip is valid' do
      let(:ip) { '178.204.73.174' }

      it do
        expect(subject.ip).to eq(ip)
      end
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

    context 'ip is not found' do
      let(:ip) { '134.234.3.2' }

      it { expect(subject.ip).to eq(ip) }
      it { expect(subject.city).to eq(nil) }
    end
  end
end