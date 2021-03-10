require 'oystercard'
# challenge 3: I want to my card to have a balance
describe Oystercard do
  let(:card) { Oystercard.new }

  let(:station) { double("Hackney") }

  it 'creates a new card with a balance of 0' do
    expect(card.balance).to eq(0)
  end
  describe '#top_up' do
    context 'before reaching card limit' do
    # challenge 5: I want to top up my card
      it 'tops up the balance of the card' do
        # allow(card).to receive(:balance) { 0 }
        expect(card.top_up(5)).to eq(5)
      end
    end
    context 'going over card limit' do
    # challenge 6: I want a maximum amount
      it 'raises an error' do
        expect { card.top_up(91) }.to raise_error 'Maximum balance reached'
      end
    end
  end
  # challenge 7
  # describe '#deduct()' do
  #   context "when you tap out"
  #     it 'deducts an amount from the balance' do
  #     subject.top_up(20)
  #     expect{ subject.deduct 3}.to change{ subject.balance }.by -3
  #
  #   end
  # end

  #challenge 8
  describe '#in_journey?' do
    it 'return false when not in journey' do
      expect(card.in_journey?).to eq(false)
    end
  end

  describe '#touch_in' do
    context 'when equal to or above minimum balance' do
      before(:each) do
        @card = Oystercard.new
        @card.top_up(5)
      end

      it 'set in_journey? to true' do

        @card.touch_in(station)
        expect(@card.in_journey?).to eq(true)
      end

      it 'return station name' do
        card.top_up(5)
        card.touch_in(station)
        expect(card.entry_station).to eq(station)
      end

      it 'accepts an argument' do
        expect(@card).to respond_to(:touch_in).with(1).argument
      end



    
    end
    #Challenge 9
    context 'when below the minimum balance' do
      it "raises an error when you touch in" do
        expect { card.touch_in(station) }.to raise_error "Balance below minimum."
      end
    end
  end

  describe '#touch_out' do
    before(:each) do
      card.top_up(5)
      card.touch_in(station)
    end
    it 'sets in_journey? to false' do
      card.touch_out
      expect(card.in_journey?).to eq(false)
    end
    it 'returns touch-out confirmation' do
      expect(card.touch_out).to eq("Touched out successfully")
    end
    it "deducts fare from balance" do
       expect { card.touch_out }.to change { card.balance }.by(-1)
    end
    it 'resets the entry_station variable to nil' do
      card.touch_out
      expect(card.entry_station).to eq(nil)
    end
  end
end 
