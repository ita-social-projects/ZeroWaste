require 'rails_helper'
require 'functions/since.rb'

RSpec.describe Since, type: :function do
  subject { Since }

  it {
    is_expected.to respond_to(:calculate_units)
  }

  describe "#calculate_units" do
    let(:calculator) { Dentaku::Calculator.new }
    let(:calculate_units) { Since.calculate_units }
    let!(:since) { calculator.add_function(:since, :numeric, calculate_units) }
    let(:date) { Date.new(2001,01,01) }

    it {
      expect(calculate_units).to be_a(Proc)
    }

    it {
      expect(calculate_units.call(date, 'day')).to be(7423)
    }

    # it {
    #   expect(calculator.evaluate('SINCE(date, "day")')).to be(7423)
    # }
  end
end
