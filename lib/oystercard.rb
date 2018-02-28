class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance

  def initialize(balance: 0)
    @balance = balance
    @in_journey = false
  end

  def topup(amount)
    fail "You can't top up as it exceeds the limit" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
  	if @in_journey
  	  true
  	else
  	  false
  	end  	
  end

  def touch_in
  	fail "Minimum balance required to touch in is £1" if @balance < MINIMUM_BALANCE
    @in_journey = true
  end
  
  def touch_out
  	deduct(1)
    @in_journey = false
  end  	

  private
  def deduct(fare)
    @balance -= fare
  end
end


#teneray operator @in_journey == true ? true : false