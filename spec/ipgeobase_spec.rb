describe Ipgeobase do
  describe '.get' do
    subject { Ipgeobase.get(ip) }

    context 'ip is valid' do
      let(:ip) { '178.204.73.174' }

      its(:ip) { is_expected.to eq(ip) }
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

      its(:ip) { is_expected.to eq(nil) }
      its(:city) { is_expected.to eq(nil) }
    end

    context 'ip is not found' do
      let(:ip) { '134.234.3.2' }

      its(:ip) { is_expected.to eq(ip) }
      its(:city) { is_expected.to eq(nil) }
    end
  end
end