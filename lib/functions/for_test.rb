# frozen_string_literal: true

class Human
  attr_accessor :age, :gender

  def initialize(age, gender)
    @age = age
    @gender = gender
  end

  def breath
    puts 'Breathing'
  end

  def eat
    puts 'Eating'
  end

  def to_s
    puts "Age: #{'year'.pluralize(count: @age)}; Gender: #{@gender}"
  end
end
