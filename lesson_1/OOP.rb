#Inheritance OOP Exercises

class Student
  attr_accessor :name
  attr_writer :grade
  
  def initialize(name, grade)
    @name = name
    @grade = grade
  end
  
  def better_grade_than?(other_student)
    grade > other_student.grade ? true : false
  end
  
  protected
  attr_reader :grade
end

joe = Student.new("Joe", 90)
bob =  Student.new("Bob", 80)
puts "Well done!" if joe.better_grade_than?(bob)
=begin
module Liftable
  def lift
    puts "Now I can ride high!"
  end
end

class Vehicle
  attr_accessor :speed, :color
  attr_reader :model, :year
  
  @@number_of_vehicles = 0
  
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
    @@number_of_vehicles += 1
  end
  
  def age
    age_calculation
  end
  
  def speed_up(number)
    self.speed = number
  end
  
  def brake(number)
    self.speed = self.speed - number
  end
  
  def turn_off
    self.speed = 0
  end
  
  def spray_paint(color)
    self.color = color
  end
  
  def to_s
    "#{self.year}, #{self.model}, color: #{self.color}, current speed: #{self.speed}"
  end
  
  private
  
  def age_calculation
    Time.now.year - self.year
  end
end

class MyCar < Vehicle
  @@number_of_cars = 0
  TYPE = "sedan"
    
  def initialize(year, color, model)
    super(year, color, model)
    @@number_of_cars += 1
  end
  
  def self.what_am_i
    "I'm a car class!"
  end
end

class MyTruck < Vehicle
  TYPE = "truck"
  include Liftable
end
=end

#Chapter II Exercises
#Question 1


kia = MyCar.new(2012, "Silver", "Rio")
puts MyCar.ancestors

toyota = MyTruck.new(2018, "Blue", "Tacoma")
puts MyTruck.ancestors

puts kia.age
puts toyota.age

#More Exercises
#Question 1: 


# Exercises
#Question: create an object via instantiation
=begin
class Animal
end

rabbit = Animal.new
=end
#Question2: what is a module?
=begin
A module is a container for a set of behaviors.
By using include within a class definition, we
can mixin that functionality to any number of 
classes or subclasses.
=end

