require 'oystercard'
describe Oystercard do
  let(:journey){ double :journey }
  subject(:oystercard) {described_class.new(journey)}
  amount = 10
  let(:entry_station){ double name: "Moorgate", zone: 1 }
  let(:exit_station) { double name: "Aldgate", zone: 2 }

  it 'should have a balance' do
    expect(subject.balance).to eq(0)
  end

  it 'should top up card and print balance' do
    expect(subject.top_up(amount)).to eq(amount)
  end

  # it 'a) should deduct money from card and print balance' do
  #  subject.top_up(65)
  #  expect(subject.deduct(20)).to eq(45)
  # end

  # it 'b) should deduct money from the card and print balance' do
  #  subject.top_up(65)
  #  expect{ subject.deduct(20) }.to change{ subject.balance }.by -20
  # end

  it 'should prevent a customer having more than £90 on their card' do
    limit = Oystercard::LIMIT
    subject.top_up(amount)
    expect { subject.top_up(limit) }.to raise_error "Top-up failed. Sorry £#{limit} is the limit on a card"
  end

  it 'customer denied journey due to insufficient funds' do
    expect { subject.touch_in(entry_station) }.to raise_error 'Sorry insufficient credit to make journey'
  end
  # let(:current_journey) { double :journey_class, calculate_fare: 2, set_end: exit_station }
  it 'shows balance reduce after touch_in' do
    allow(journey).to receive(:calculate_fare) {2}
    allow(journey).to receive(:set_end) {exit_station}
    allow(journey).to receive(:set_start) {entry_station}
    allow(journey).to receive(:journey_store) {  {
        Entry_station: entry_station,
        Exit_station: exit_station,
        Price: journey.calculate_fare
      }}
    subject.top_up(amount)
    subject.touch_in(entry_station)
    expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-journey.calculate_fare)
  end

end
