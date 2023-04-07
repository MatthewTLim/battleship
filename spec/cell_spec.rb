require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  describe '#initialize' do 
    it 'exists' do 
      cell = Cell.new("B4")

      expect(cell).to be_a(Cell)
    end

    it 'has readable attributes' do 
      cell = Cell.new("B4")

      expect(cell.coordinate).to eq("B4")
    end
  end
end