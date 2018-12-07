class Shelter
  def initialize
    @all_adoptions = {}
  end

  def adopt(new_owner, pet)
    if @all_adoptions[new_owner.name]
      @all_adoptions[new_owner.name].push(pet)
    else
      @all_adoptions[new_owner.name] = [pet]
    end
    new_owner.pets.push(pet)
  end

  def print_adoptions
    @all_adoptions.each do |k, v|
      puts "#{k} has adopted the following pets:"
      v.each do |pet|
        puts "a #{pet.species} named #{pet.name}"
      end
      puts ""
    end
  end
end

class Pet
  attr_reader :species, :name

  def initialize(species, name)
    @species = species
    @name = name
  end
end

class Owner
  attr_reader :name
  attr_accessor :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def number_of_pets
    @pets.count
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."


=begin
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