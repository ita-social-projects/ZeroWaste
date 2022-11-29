# frozen_string_literal: true

class Human
  def initialize(name, age, gender)
    @name = name.capitalize
    @age = age
    @gender = gender
  end

  def move
    puts "#{@name} moves"
  end

  def eat
    puts "#{@name} eats"
  end

  def sleep
    puts "#{@name} sleep"
  end

  def to_s
    "Name: #{@name}; Age: #{@age} #{'year'.pluralize(count: @age)}"
  end
end
