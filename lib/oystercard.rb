class Oystercard

  MAXIMUM_BALANCE = 90

  attr_reader :balance

  def initialize(balance: 0)
    @balance = balance
    @in_journey = false
  end

  def topup(amount)
    fail "You can't top up as it exceeds the limit" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  def touch_in
    @in_journey = true
  end

end
