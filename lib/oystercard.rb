class Oystercard
  attr_reader :balance
  DEFAULT_BALANCE = 0
  MINIMUM_BALANCE = 1
  CARD_LIMIT = 90
  MINIMUM_FARE = 1
  def initialize
    @balance = DEFAULT_BALANCE
    @in_journey = false
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
    @in_journey
  end

  def touch_in
    fail "Balance below minimum." if @balance < MINIMUM_BALANCE
    @in_journey = true
    "Touched in successfully"
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @in_journey = false
    "Touched out successfully"
  end
  private  
  def deduct(charge)
    @balance -= charge
  end
end
