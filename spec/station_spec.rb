require 'station'

describe Station do

  subject(:station) { described_class.new("Moorgate", 1) }

  it 'should have a name' do
    expect(subject.name).to eq('Moorgate')
  end

  it 'should have a zone' do
    expect(subject.zone).to eq(1)
  end
end
