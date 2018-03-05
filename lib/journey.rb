class Journey
  attr_reader :entry_station, :exit_station
  PENALTY_FARE = 6
  def initialize(entry_station: nil, zone: 1)
    @entry_station = entry_station
    @exit_station = nil
  end	

  def complete?
    !!@exit_station && !!@entry_station
  end  

  def fare
    complete? ? Oystercard::MINIMUM_BALANCE : PENALTY_FARE   
  end
  
  def finish(exit_station)
    self
  end

end
