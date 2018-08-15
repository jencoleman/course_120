class MotorizedVehicle
  attr_accessor :speed, :heading

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @fuel_efficiency = km_traveled_per_liter
    @fuel_capacity = liters_of_fuel_capacity
    @tires = tire_array
  end

  def range
    @fuel_capacity * @fuel_efficiency
  end
end
    
module Land
  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
end

class Auto < MotorizedVehicle
  include Land
  def initialize
    # 4 tires are various tire pressures
    super([30,30,32,32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  include Land
  
  def initialize
    # 2 tires are various tire pressures
    super([20,20], 80, 8.0)
  end
end

class Catamaran
  attr_accessor :propeller_count, :hull_count

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    # ... code omitted ...
  end
end

class Motoboat < Catamaran
  super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
end
  

=begin
class SecretFile

  def initialize(secret_data)
    @data = secret_data
  end
  
  def data
    log = SecurityLogger.new
    log.create_log_entry
    @data
  end
end


class KrispyKeme
  attr_reader :type :topping
  
  def initialize(type, topping)
    @type = type
    @topping = topping
  end
  
  def to_s
    string = nil
    @type == nil ? string.push("Plain") : string.push(type)
    if @topping != nil
      string.push("with #{topping}")
    end
    string
  end
end


class Greeting
  def greet(string)
    puts string
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def goodbye
    greet("Goodbye")
  end
end


class Cat
  def initialize(type)
    @type = type
  end
  
  def to_s
    "I am a #{@type} cat."
end