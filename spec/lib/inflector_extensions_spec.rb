require 'rails_helper'

RSpec.describe '#pluralize' do
  context 'months' do
    let(:months) do
      {
        1 => 'місяць',
        2 => 'місяці',
        3 => 'місяці',
        4 => 'місяці',
        5 => 'місяців',
        6 => 'місяців',
        7 => 'місяців',
        8 => 'місяців',
        9 => 'місяців',
        10 => 'місяців',
        11 => 'місяців',
        0 => 'місяців'
      }
    end

    it 'properly pluralizes all months' do
      months.each do |count, expected|
        expect('місяць'.pluralize(count, :uk)).to eq(expected)
      end
    end
  end

  context 'years' do
    let(:years) do
      {
        0 => 'років',
        1 => 'рік',
        2 => 'роки'
      }
    end

    it 'properly pluralizes all years' do
      years.each do |count, expected|
        expect('рік'.pluralize(count, :uk)).to eq(expected)
      end
    end
  end

  context 'common cases with english locale' do
    context 'words that can be plural' do
      it 'pluralizes properly without count parameter' do
        expect('dog'.pluralize).to eq('dogs')
        expect('cat'.pluralize).to eq('cats')
        expect('octopus'.pluralize).to eq('octopi')
        expect('buffalo'.pluralize).to eq('buffaloes')
        expect('mouse'.pluralize).to eq('mice')
      end

      it 'pluralizes properly with count parameter' do
        expect('dog'.pluralize(10)).to eq('dogs')
        expect('cat'.pluralize(1)).to eq('cat')
        expect('alias'.pluralize(123)).to eq('aliases')
        expect('buffalo'.pluralize(1, :en)).to eq('buffalo')
        expect('bus'.pluralize(0)).to eq('buses')
      end

      it 'pluralizes irregular words properly' do
        expect('person'.pluralize(10)).to eq('people')
        expect('man'.pluralize(1)).to eq('man')
        expect('child'.pluralize(0)).to eq('children')
        expect('zombie'.pluralize).to eq('zombies')
        expect('sex'.pluralize(666)).to eq('sexes')
      end
    end

    context 'words that cannot be plural' do
      it 'does not pluralize uncountable words' do
        expect('equipment'.pluralize(10)).to eq('equipment')
        expect('information'.pluralize).to eq('information')
        expect('rice'.pluralize(0)).to eq('rice')
        expect('money'.pluralize(1)).to eq('money')
        expect('fish'.pluralize(666)).to eq('fish')
      end
    end
  end
end
