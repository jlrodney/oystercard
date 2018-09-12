# require_relative 'station.rb'
# require_relative 'journey'
class Oystercard
    LIMIT = 90
    DEFAULT_BALANCE = 0
    MIN_BALANCE_FOR_JOURNEY = 1
    attr_reader :balance, :journey, :current_journey

    def touch_in(station)
      fail 'Sorry insufficient credit to make journey' unless balance > MIN_BALANCE_FOR_JOURNEY
      @current_journey = journey
      current_journey.set_start(station)
    end

    def touch_out(exit_station)
      #deduct(CHARGE)
      #Oystercard.balance
      current_journey.set_end(exit_station)
      fare = current_journey.calculate_fare
      @journey_list << current_journey.journey_store
      deduct(fare)
    end

  def initialize(journey = Journey.new, balance = DEFAULT_BALANCE)
      @balance = balance
      @journey = journey
      @journey_list = []
  end

  def top_up(money)
    fail "Top-up failed. Sorry £#{LIMIT} is the limit on a card" if (@balance + money) > LIMIT
    @balance += money
  end


  # def number
  #   i = @journey_list.count + 1
  #   journey + 1
  # end

  #def limit_reached?
  #    fail 'Top-up failed. Sorry £90 is the limit on a card' if @default_balance + money > 90
  #end
  private
  def deduct(money)
    @balance -= money
  end

end
