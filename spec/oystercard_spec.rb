require 'oystercard'
# challenge 3: I want to my card to have a balance
describe Oystercard do
  let(:card) { Oystercard.new }

  let(:station) { double("Hackney") }
  let(:station2) { double("Moorgate") }

  it 'creates a new card with a balance of 0' do
    expect(card.balance).to eq(0)
  end
  describe '#top_up' do
    context 'before reaching card limit' do
    # challenge 5: I want to top up my card
      it 'tops up the balance of the card' do
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

  #challenge 8
  describe '#in_journey?' do
    let(:new_card) { Oystercard.new }

    it 'return false when not in journey' do
      # p new_card.journey
      # p new_card.journey[:entry]
      # expect(new_card.in_journey?).to eq(false)
      expect(new_card).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    context 'when equal to or above minimum balance' do
      let(:topped_up_card) { Oystercard.new }

      before(:each) do
        topped_up_card.top_up(5)
      end

      it 'set in_journey? to true' do
        topped_up_card.touch_in(station)
        expect(topped_up_card.in_journey?).to eq(true)
      end

      it 'accepts an argument' do
        expect(topped_up_card).to respond_to(:touch_in).with(1).argument
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
    let(:active_card) { Oystercard.new }
    before(:each) do
      active_card.top_up(5)
      active_card.touch_in(station)
    end

    it 'sets in_journey? to false' do
      active_card.touch_out(station2)
      # expect(active_card.in_journey?).to eq(false)
      # p active_card.journey
      expect(active_card).not_to be_in_journey
    end
    
    it 'returns touch-out confirmation' do
      expect(active_card.touch_out(station)).to eq("Touched out successfully")
    end
    
    it "deducts fare from balance" do
       expect { active_card.touch_out(station) }.to change { active_card.balance }.by(-1)
    end
  end

  describe "#history" do
    it "returns an empty history" do
      expect(card.history).to eq []
    end
    
    # Old test, no longer necessary:
    # it 'resets the entry_station variable to nil' do
    #   card.touch_out(station)
    #   expect(card.entry_station).to eq(nil)
    # end

    it "returns a journey history" do
      card.top_up(5)
      card.touch_in(station)
      card.touch_out(station2)
      # p card.history
      # p card.journey
      expect(card.history[0]).to eq({ entry: station, exit: station2})
    end

    # Older test, no longer necessary:
    # it 'return station name' do
    #   card.top_up(5)
    #   card.touch_in(station)
    #   expect(card.entry_station).to eq(station)
    # end
  end
end
