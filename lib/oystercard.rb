class Oystercard
  attr_reader :balance, :entry_station, :history
  DEFAULT_BALANCE = 0
  MINIMUM_BALANCE = 1
  CARD_LIMIT = 90
  MINIMUM_FARE = 1
  JOURNEY_TEMPLATE = { entry: nil, exit: nil}

  def initialize
    @balance = DEFAULT_BALANCE
    @history = []
    @journey = JOURNEY_TEMPLATE
  end

  def top_up(amount)
    @balance += amount
    raise 'Maximum balance reached' if @balance > CARD_LIMIT
    @balance
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @entry_station.nil? ? false : true
  end

  def touch_in(station)
    fail "Balance below minimum." if @balance < MINIMUM_BALANCE
    @entry_station = station
    @journey[:entry] = station
    # @history << {station: nil}
    "Touched in successfully"
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @journey[:exit] = station
    @history << @journey
    @journey = JOURNEY_TEMPLATE
    @entry_station = nil
    "Touched out successfully"
  end
private
  def deduct(charge)
    @balance -= charge
  end
end
