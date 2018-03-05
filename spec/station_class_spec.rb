require 'station.rb'
describe Station do
  subject { described_class.new(name: "Kings Cross", zone: 1) }
  it 'knows its station name' do
    expect(subject.name).to eq("Kings Cross")
  end
  it 'knows its zone' do
    expect(subject.zone).to eq(1)
  end
end      