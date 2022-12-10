RSpec.describe CategoryableCategory, type: :model do
  describe 'validations' do
    context 'when categoryable are valid' do

      it 'returns valid record' do
        expect(product.categories).not_to eq(budgetary_price)
      end
    end
  end
end
