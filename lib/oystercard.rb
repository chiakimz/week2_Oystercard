class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance, :entry_station, :exit_station, :journey, :history

  def initialize(balance: 0)
    @balance = balance
    @entry_station = entry_station
    @exit_station = exit_station
    @journey = {}
    @history = []
  end

  def topup(amount)
    fail "You can't top up as it exceeds the limit" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
  	!@entry_station.nil?  	
  end

  def touch_in(entry_station)
  	fail "Minimum balance required to touch in is £1" if @balance < MINIMUM_BALANCE
    @entry_station = entry_station
    @journey[:entry_station] = @entry_station
  end
  
  def touch_out(exit_station)
  	deduct(1)
  	@exit_station = exit_station
    @journey[:exit_station] = @exit_station
    @entry_station = nil   
    @history << @journey

  end  	

  def journey_history
    history = []
  end  	

  private
  def deduct(fare)
    @balance -= fare
  end
end


#teneray operator @in_journey == true ? true : false

# journey = {entry_station: @entry_station, exit_station: @exit_station}
# journey[:entry_station] = 