require 'oystercard'
# challenge 3: I want to my card to have a balance
describe Oystercard do
  # card = Oystercard.new
  let(:card) { Oystercard.new }
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
      it 'set in_journey? to true' do
        card.top_up(5)
        card.touch_in
        expect(card.in_journey?).to eq(true)
      end
      it 'return touch-in confirmation' do
        card.top_up(5)
        expect(card.touch_in).to eq("Touched in successfully")
      end
    end
    #Challenge 9
    context 'when below the minimum balance' do
      it "raises an error when you touch in" do
        expect { card.touch_in }.to raise_error "Balance below minimum."
      end
    end
  end

  describe '#touch_out' do
      # card.top_up(5)
      #let(:used_card) { Oystercard.new.top_up(5).touch_in }

    it 'sets in_journey? to false' do
      # active_card.touch_in
      card.top_up(5)
      card.touch_in
      card.touch_out
      expect(card.in_journey?).to eq(false)
    end
    it 'returns touch-out confirmation' do
      card.top_up(5)
      card.touch_in
      expect(card.touch_out).to eq("Touched out successfully")
    end
     it "deducts fare from balance" do
       card.top_up(5)
       card.touch_in
       expect { card.touch_out }.to change { card.balance }.by(-1)
     end
  end
end
