Animal
-- Mammals
---- Dog
---- Platypus
-- Birds
---- Parrot

class Vehicle
  def pop_a_wheelie
    puts "I'm doing a wheelie."
  end
end


class Motorized < Vehicle
end

class NonMotorized < Vehicle
end

class Bicycle < NonMotorized
end

class Motorcycle < Motorized
end

class Car < Motorized
end