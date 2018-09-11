require 'oystercard'
describe Oystercard do

  it 'should have a balance' do
    expect(subject.balance).to eq(0)
  end

  it 'should top up card and print balance' do
    expect(subject.top_up(5)).to eq(5)
  end

  # it 'a) should deduct money from card and print balance' do
  #  subject.top_up(65)
  #  expect(subject.deduct(20)).to eq(45)
  # end

  # it 'b) should deduct money from the card and print balance' do
  #  subject.top_up(65)
  #  expect{ subject.deduct(20) }.to change{ subject.balance }.by -20
  # end

  it 'shows that initially a customer is not in a journey' do
    expect(subject.in_journey?).to eq false
  end

  let(:entry_station){ double :Moorgate }
  let(:exit_station) {double :Aldgate}

  it 'customer denied journey due to insufficient funds' do
    expect { subject.touch_in(entry_station) }.to raise_error 'Sorry insufficient credit to make journey'
  end

  it 'shows customer is in journey after touch_in' do
    subject.top_up(10)
    subject.touch_in(entry_station)
    expect(subject.in_journey?).to eq true
  end

  it 'shows balance reduce after touch_in' do
    subject.top_up(10)
    subject.touch_in(entry_station)
    expect { subject.touch_out(exit_station) }.to change {subject.balance}.by(-Oystercard::CHARGE)
  end

  it "shows touch in then touch out: customer wont be in journey" do
    subject.top_up(10)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.in_journey?).to eq false
  end

  it 'should prevent a customer having more than £90 on their card' do
    limit = Oystercard::LIMIT
    subject.top_up(5)
    expect { subject.top_up(limit) }.to raise_error "Top-up failed. Sorry £#{limit} is the limit on a card"
  end

  it 'should print/remember entry station' do
    subject.top_up(10)
    subject.touch_in(entry_station)
    expect(subject.entry_station).to eq entry_station
  end

  it 'should show noting in list of journeys by default' do
    expect(subject.journey_list).to be_empty
  end

  let(:journey){ {Entry_station: entry_station, Exit_station: exit_station} }

  it 'stores a journey' do
    subject.top_up(10)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.journey_list).to include journey
  end

end
