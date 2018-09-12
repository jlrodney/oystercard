
require_relative 'oystercard'
class Journey

  def initialize
    @in_use = false
  end

  CHARGE = 2
  PENALTY_CHARGE = 6

  attr_reader :start_station, :finish_station, :in_use

  def set_start(station)
    @in_use = true
    @start_station = station.name
  end

  def set_end(station)
    @in_use = false
    @finish_station = station.name
  end

  def calculate_fare
    if start_station != nil || finish_station !=nil
      CHARGE
    else
      PENALTY_CHARGE
    end
  end


  def journey_store
    {
      Entry_station: start_station,
      Exit_station: finish_station,
      Price: calculate_fare
    }
  end

  def in_journey?
    # !! converts the value to a boolean
    in_use
  end
end
