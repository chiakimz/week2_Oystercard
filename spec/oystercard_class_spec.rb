require "oystercard.rb"
describe Oystercard do
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
      expect{ subject.deduct 1 }.to change{ subject.balance }.by -1
    end
  end

  describe "#in_journey?" do
    it "returns true if in journey" do
      subject.topup(1)
      subject.touch_in
      expect(subject.in_journey?).to eq true
    end
  end
  
  describe "touch_in" do
    it "returns true if you touch in" do
      subject.topup(1)
      expect(subject.touch_in).to eq true
    end
    it "raises an error when the balance is below £1" do
      #minimum_balance = Oystercard::MINIMUM_BALANCE
      message = "Minimum balance required to touch in is £1"
      expect { subject.touch_in }.to raise_error message
    end  
  end

  describe "touch_out" do
    it "returns true if you touch out" do
      expect(subject.touch_out).to eq false
    end
    it "deducts a fare for the journey" do
      subject.topup(1)
      expect { subject.touch_out }.to change { subject.balance }.by -1 #subject.deduct(fare) )
    end  
  end             

end


