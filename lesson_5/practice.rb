module Transportation
  class Vehicle; end
  class Truck < Vehicle; end
  class Car < Vehicle; end
end

=begin module Towable
  def tow
    'I can tow a trailer!'
  end
end

class Vehicle
  attr_reader :year
  
  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle
  include Towable
end

class Car < Vehicle
end

truck1 = Truck.new(1994)
puts truck1.year
puts truck1.tow

car1 = Car.new(2006)
puts car1.year

=begin
class Person
end
person1 = Person.new
person1.secret = 'Shh..this is a secret!'

person2 = Person.new
person2.secret = 'Shh.. this is a different secret!'


puts person1.compare_secret(person2)

=begin
class Cat
  attr_reader :name, :color
  @@count = 0
  COLOR = 'tortie'
  
  def initialize(name)
    @name = name
    @@count += 1
  end

  def rename(new_name)
    @name = new_name
  end

  def self.generic_greeting
    puts "Meow."
  end
  
  def identify
    self
  end
  
  def greet
    puts "Hi, my name is #{name}, and I'm a #{COLOR} cat!"
  end
  
  def self.total
    puts @@count
  end
  
  def to_s
    "I'm #{name}!"
  end
end

kitty = Cat.new('Sophie')
puts kitty.name
kitty2 = Cat.new('Chloe')
kitty2.greet
puts kitty2

=begin
module Walkable
end

class Cat
  include Walkable
  attr_accessor :name

  def initialize(name)
    @name = name

  end
  
  def greet
    puts "Hi! I'm #{name}."
  end
end

kitty = Cat.new('Sophie')
kitty.name = 'Luna'
kitty.greet
kitty.walk
=end