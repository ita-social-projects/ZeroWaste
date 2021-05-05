# frozen_string_literal: true

require 'rails_helper'
require 'functions/in'

RSpec.describe InClass, type: :function do
  subject { InClass }
  let(:get_params) { InClass.get_params }
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

  it {
    is_expected.to respond_to(:get_params)
  }

  describe '#get_params' do
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
  end
end
