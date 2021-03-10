class Oystercard
  attr_reader :balance, :entry_station
  DEFAULT_BALANCE = 0
  MINIMUM_BALANCE = 1
  CARD_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = DEFAULT_BALANCE
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
    "Touched in successfully"
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
    "Touched out successfully"
  end
private   
  def deduct(charge)
    @balance -= charge
  end
end
