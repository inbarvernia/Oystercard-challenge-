class Oystercard
  attr_reader :balance
  DEFAULT_BALANCE = 0
  CARD_LIMIT = 90

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
    @in_journey = true
    "Touched in successfully"
  end

  def touch_out
    @in_journey = false
    "Touched out successfully"
  end
end
