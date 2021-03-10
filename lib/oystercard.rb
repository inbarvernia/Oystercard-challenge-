class Oystercard
  attr_reader :balance, :history, :journey
  DEFAULT_BALANCE = 0
  MINIMUM_BALANCE = 1
  CARD_LIMIT = 90
  MINIMUM_FARE = 1
  JOURNEY_TEMPLATE = { entry: nil, exit: nil }

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
    # p @journey[:entry]
    @journey[:entry].nil? ? false : true
  end

  def touch_in(station)
    fail "Balance below minimum." if @balance < MINIMUM_BALANCE
    @journey[:entry] = station
    "Touched in successfully"
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @journey[:exit] = station
    journey_to_history
    "Touched out successfully"
  end

private
  def deduct(charge)
    @balance -= charge
  end

  def journey_to_history
    @history.push(@journey)
    # @journey = JOURNEY_TEMPLATE
    # @journey[:entry] = nil
    # @journey[:exit] = nil
    @journey = { entry: nil, exit: nil }
  end
end
