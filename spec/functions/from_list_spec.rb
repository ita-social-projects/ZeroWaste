# frozen_string_literal: true

require 'rails_helper'
require 'functions/from_list'

RSpec.describe FromList, type: :function do
  subject { FromList }
  let(:get_params) { FromList.to_hash }
  let(:calculator) { build(:calculator) }
  let(:range1) do
    create(:range_field, from: 5, type: 'Calculation', label: 'label',
                         kind: 'form', calculator: calculator, to: 19, value: '56')
  end
  let(:range2) do
    create(:range_field, from: 6, type: 'Calculation', label: 'label',
                         kind: 'form', calculator: calculator, to: 20, value: '57')
  end
  let(:range3) do
    create(:range_field, from: 7, type: 'Calculation', label: 'label',
                         kind: 'form', calculator: calculator, to: 21, value: '58')
  end

  let(:range4) { 5 }
  let(:range5) { '7854'}
  let(:range6) { '' }


  describe '#to_hash' do
    it {
      expect(get_params.call([range1, range2, range3])).to be_kind_of(Hash)
    }

    context "when 'from','to' and 'value' are valid" do
      it {
        expect(get_params.call([range1])).to eq({ range1 => { range1.from..range1.to => range1.value } })
      }
      it {
        expect(get_params.call([range2])).to eq({ range2 => { range2.from..range2.to => range2.value } })
      }
      it {
        expect(get_params.call([range3])).to eq({ range3 => { range3.from..range3.to => range3.value } })
      }
    end

    context "when 'from','to' and 'value' are invalid" do
      it {
        expect { get_params.call([range4]) }.to raise_error(ArgumentError)
      }
      it {
        expect { get_params.call([range5]) }.to raise_error(ArgumentError)
      }
      it {
        expect { get_params.call([range6]) }.to raise_error(ArgumentError)
      }
    end
  end
end
