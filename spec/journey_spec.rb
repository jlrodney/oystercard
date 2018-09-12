require 'journey'
describe Journey do

  it 'shows that initially a customer is not in a journey' do
    expect(subject.in_journey?).to eq false
  end

  let(:entry_station){ double name: "Moorgate", zone: 1 }
  let(:exit_station) { double name: "Aldgate", zone: 2 }
  let(:oystercard) { double  balance: 10 }

  let(:s) { subject.set_start(entry_station) }
  let(:t) { subject.set_end(exit_station) }

  it 'shows customer is in journey after touch_in' do
    s
    expect(subject.in_journey?).to eq true
  end

  it 'shows balance reduce after touch_in' do
    s
    expect { subject.set_start(exit_station) }.to change {subject.balance}.by(-CHARGE)
  end

  it 'should print/remember entry station' do
    s
    expect(subject.entry_station).to eq entry_station
  end

  it "shows touch in then touch out: customer wont be in journey" do
    s
    t
    expect(subject.in_journey?).to eq false
  end

  let(:journey){ {Entry_station: entry_station, Exit_station: exit_station} }

  it 'stores a journey' do
    s
    t
    expect(subject.journey_store).to include journey_store
  end

end
