require 'rails_helper'
require 'functions/since.rb'

RSpec.describe Since, type: :function do
  subject { described_class }

  it {
    is_expected.to respond_to(:calculate_units)
  }

  describe "#calculate_units" do
    let(:calculate_units) { Since.calculate_units }
    let(:from) { Date.new(2020,01,01) }
    let(:to) { Date.new(2021,01,31) }
    let(:invalid_date_format) { Time.new(2001,01,01) }

    it {
      expect(calculate_units).to be_a(Proc)
    }

    context "when unit is `day`" do
      it {
      expect(calculate_units.call(from, to, 'day')).to be(396)
      }
    end

    context "when unit is `month`" do
      it {
      expect(calculate_units.call(from, to, 'month')).to be(13)
      }
    end

    context "when unit is `year`" do
      it {
      expect(calculate_units.call(from, to, 'year')).to be(1)
      }
    end

    context "when `unit` is invalid" do
      it {
      expect { calculate_units.call(from, to, 'century') }.to raise_error(ArgumentError)
      }
    end

    context "when `from` format is invalid" do
      it {
      expect { calculate_units.call(invalid_date_format, to, 'day') }.to raise_error(ArgumentError)
      }
    end

    context "when `to` format is invalid" do
      it {
      expect { calculate_units.call(from, invalid_date_format, 'day') }.to raise_error(ArgumentError)
      }
    end
  end
end
