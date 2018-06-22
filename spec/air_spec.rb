require_relative '../air'

describe AirCraft do
  describe 'create' do
    context 'AirCraft seat set up' do
      let(:input_1) { [[3,2],[4,3],[2,3],[3,4]] }
      let(:input_2) { [] }
      let(:input_3) { [[1]] }
      let(:input_4) { [[1,1]] }

      it '36 seats' do
        expect(AirCraft.new(input_1).info).to eq({seat_count: 36})
      end

      it '0 seats' do
        expect(AirCraft.new(input_2).info).to eq({seat_count: 0})
      end

      it '0 seats second type' do
        expect(AirCraft.new(input_3).info).to eq({seat_count: 0})
      end

      it '1 seat' do
        expect(AirCraft.new(input_4).info).to eq({seat_count: 1})
      end
    end

    context 'arrange passenger' do
      let(:input_1) { [[3,2],[4,3],[2,3],[3,4]] }
      let(:air_craft) { AirCraft.new(input_1) }

      it '36 seats 30 passenger' do
        air_craft.assign_passenger(30)
        expect(air_craft.seats.first.passenger).to eq(19)
      end

      it '36 seats 40 passenger' do
        air_craft.assign_passenger(40)
        expect(air_craft.seats.first.passenger).to eq(0)
      end

    end

  end
end
