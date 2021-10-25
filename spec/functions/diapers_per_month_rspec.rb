# frozen_string_literal: true

require 'rails_helper'
require 'functions/diapers_per_month'

describe DiapersPerMonth do
  let(:function) { described_class.new }
  let(:data) { { 0..2 => 30, 3..5 => 70 } }

  describe '#call' do
    let(:expectations) do
      {
        2 => 90,
        5 => 300,
        4 => 230,
        1 => 60
      }
    end
    it 'properly calculates all results' do
      expectations.each do |month, expected|
        expect(function.call(month, data)).to eq(expected)
      end
    end
  end
end
