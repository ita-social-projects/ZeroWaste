require 'rails_helper'
require 'codecov_example'

RSpec.describe Human do
  let(:human) { Human.new('Marian', 20, 'man') }

  it 'prints properly during #move' do
    expect { human.move }.to output(/Marian moves/).to_stdout
  end

  it 'prints properly during #eat' do
    expect { human.eat }.to output(/Marian eats/).to_stdout
  end

  it 'prints properly during #sleep' do
    expect { human.sleep }.to output(/Marian sleep/).to_stdout
  end

  it 'runs #to_s properly' do
    expect(human.to_s).to eq('Name: Marian; Age: 20 years')
  end
end
