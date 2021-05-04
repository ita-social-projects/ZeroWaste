# frozen_string_literal: true

require 'rails_helper'
require 'functions/in'

RSpec.describe InClass, type: :function do
  subject { InClass }

  it {
    is_expected.to respond_to(:get_params)
  }

  describe '#get_params' do
    let(:get_params) { InClass.get_params }
    let(:from) { [9, 16, 25] }
    let(:to) { [15, 35, 45] }
    let(:value) { '78' }

    it {
      expect(get_params).to be_a(Proc)
    }

    context "when 'from' and 'to' is valid" do
      it {
        expect {
          get_params.call(from, to, value)
          }.not_to raise_error(ArgumentError)
      }
    end

    # context "when 'to' is valid" do
    #   it {
    #     expect {get_params.call(from, to, value)}. to raise_error(ArgumentError)
    #   }
    # end

    context "when 'value' is valid" do
      it {
        expect {
          get_params.call(from, to, value)
          }.to eq {[9, 16, 25]..[15, 35, 45] => '78'}
      }
    end
  end
end
