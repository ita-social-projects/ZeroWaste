# frozen_string_literal: true

require 'rails_helper'
require 'functions/dipers_month'

describe Dipers do
  let(:dipers) { Dipers.new }

  context 'calculate' do
    it do
      expect(dipers.dipers_per_month(2,
                                     { 0..2 => 30, 3..5 => 70 })).to eq(90)
    end
  end
  context 'calculate' do
    it do
      expect(dipers.dipers_per_month(5,
                                     { 0..2 => 30, 3..5 => 70 })).to eq(300)
    end
  end
  context 'calculate' do
    it do
      expect(dipers.dipers_per_month(4,
                                     { 0..2 => 30, 3..5 => 70 })).to eq(230)
    end
  end
  context 'calculate' do
    it do
      expect(dipers.dipers_per_month(1, { 0..2 => 30, 3..5 => 70 })).to eq(60)
    end
  end
end
