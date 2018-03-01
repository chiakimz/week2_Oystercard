require "oystercard.rb"
describe Oystercard do
  let (:fake_station){double :fake_station}
  describe "#balace" do
    it "shows the amount of money that's left on card" do
      balance = 0
      expect(subject.balance).to eq balance
    end
  end

  describe "#topup" do
    it "allows user to top up" do
      expect{ subject.topup 1 }.to change{ subject.balance }.by 1
    end

    it "raises an error when the amount exceeds the limit" do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.topup(maximum_balance)
      message = "You can't top up as it exceeds the limit"
      expect{ subject.topup 1 }.to raise_error message
    end
  end

  describe '#deduct'do
    it 'deduces the fare for journey' do
      subject.topup(1)
      subject.touch_in(fake_station)
      expect{ subject.touch_out(fake_station) }.to change{ subject.balance }.by -1
    end
  end

  describe "#in_journey?" do
    it "returns true if in journey" do
      subject.topup(1)
      subject.touch_in(fake_station)
      expect(subject.in_journey?).to eq true
    end
    it "returns false if not in journey" do
      subject.entry_station == nil
      expect(subject.in_journey?).to eq false
    end  
  end
  
  describe "#touch_in(fake_station)" do
    it "raises an error when the balance is below £1" do
      message = "Minimum balance required to touch in is £1"
      expect { subject.touch_in(fake_station) }.to raise_error message
    end  
    it "remembers the station you touched the card in" do
      subject.topup(1)
      subject.touch_in(fake_station)
      expect(subject.entry_station).to eq fake_station
    end 
    it "updates a hash with an entry station" do
      subject.topup(1)
      subject.touch_in(fake_station)
      expect( subject.journey[:entry_station]).to eq fake_station 
    end  

  end

  describe "#touch_out(exit_station)" do
    before (:each) do
      subject.topup(1)
    end  
    it "deducts a fare for the journey" do
      expect { subject.touch_out(fake_station) }.to change { subject.balance }.by -1 
    end  
    it "forgets the station it touched in" do
      subject.touch_in(fake_station)
      subject.touch_out(fake_station)
      expect( subject.entry_station).to eq nil
    end
    it "updates a hash with an exit station" do 
      subject.touch_in(fake_station)
      subject.touch_out(fake_station)
      expect( subject.journey[:exit_station]).to eq fake_station
    end
    # it "makes a hash of entry station and exit station" do
    #   expect(subject.touch_out).to be_an_instance_of(Hash)
    # end    
  end   

  describe '#journey_history' do
    it "shows a history of journey including entry station and exit station" do
      expect(subject.journey_history).to be_an_instance_of(Array)
    end
  end              
end


