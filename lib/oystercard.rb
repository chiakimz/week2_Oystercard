class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance, :entry_station

  def initialize(balance: 0)
    @balance = balance
    @in_journey = false
    @entry_station = entry_station
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

  def touch_in(entry_station)
  	fail "Minimum balance required to touch in is £1" if @balance < MINIMUM_BALANCE
    @in_journey = true
    @entry_station = entry_station
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