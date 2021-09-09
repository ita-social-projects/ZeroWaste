# frozen_string_literal: true

require 'rails_helper'
require 'functions/dipers_month'

describe Dipers do
  let(:dipers) { Dipers.new }

  context 'calculate' do
    it do
      expect(dipers.dipers_per_month(2,
                                     { 0 => 30, 1 => 40, 2 => 70 })).to eq(140)
    end
  end
  context 'calculate' do
    it do
      expect(dipers.dipers_per_month(5,
                                     { 0 => 30, 1 => 30, 2 => 30, 3 => 70,
                                       4 => 70, 5 => 70 })).to eq(300)
    end
  end
  context 'calculate' do
    it do
      expect(dipers.dipers_per_month(5,
                                     { 0 => 40, 1 => 40, 2 => 70, 3 => 90,
                                       4 => 100, 5 => 100 })).to eq(440)
    end
  end
  context 'calculate' do
    it do
      expect(dipers.dipers_per_month(2, { 0 => 40, 1 => 40 })).to eq(80)
    end
  end
end
