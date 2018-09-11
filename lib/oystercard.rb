require_relative 'station.rb'
class Oystercard
    LIMIT = 90
    MIN_BALANCE_FOR_JOURNEY = 1
    CHARGE = 2
    DEFAULT_BALANCE = 0
    attr_reader :balance, :entry_station, :journey_list

  def initialize(balance = DEFAULT_BALANCE)
      @balance = balance
      @journey_list = []
  end

  def top_up(money)
    fail "Top-up failed. Sorry £#{LIMIT} is the limit on a card" if (@balance + money) > LIMIT
    @balance += money
  end

  def touch_in(station)
    @entry_station = station
    fail 'Sorry insufficient credit to make journey' unless @balance > MIN_BALANCE_FOR_JOURNEY
  end

  def touch_out(exit_station)
    deduct(CHARGE)
    journey_store(@entry_station, exit_station)
    @entry_station = nil
  end

  def journey_store(entry_station, exit_station)
    journey = {
      Entry_station: entry_station,
      Exit_station: exit_station,
    }
    @journey_list << journey
  end

  def number
    i = @journey_list.count + 1
    journey + 1
  end

  def in_journey?
    # !! converts the value to a boolean
    !!entry_station
  end

  private
  def deduct(money)
    @balance -= money
  end

  #def limit_reached?
  #    fail 'Top-up failed. Sorry £90 is the limit on a card' if @default_balance + money > 90
  #end

end
