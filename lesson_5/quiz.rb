class Customer; end

class Order
  def initialize
    @burger = Burger.new
    @side = Side.new
    @drink = Drink.new
    @meal = [@burger, @side, @drink]
  end

  def to_s
    meal.map(&:to_s).join(', ')
  end

  def total
    total_cost = @burger.cost + @side.cost + @drink.cost
    format("%.2f", total_cost) # #format formats the cost to two decimal places
  end
  def +(other)
    self.cost + other.cost
  end
end

class MealItem;
  def to_s
    "#{self.class::OPTIONS['1'][:name]}"
  end
  def cost
    stuff
  end
end

class Burger < MealItem
  OPTIONS = {
    '1' => { name: 'LS Burger', cost: 3.00 },
    '2' => { name: 'LS Cheeseburger', cost: 3.50 },
    '3' => { name: 'LS Chicken Burger', cost: 4.50 },
    '4' => { name: 'LS Double Deluxe Burger', cost: 6.00 }
  }
end

class Side < MealItem
  OPTIONS = {
    '1' => { name: 'Fries', cost: 0.99 },
    '2' => { name: 'Onion Rings', cost: 1.50 }
  }
end

class Drink < MealItem
  OPTIONS = {
    '1' => { name: 'Cola', cost: 1.50 },
    '2' => { name: 'Lemonade', cost: 1.50 },
    '3' => { name: 'Vanilla Shake', cost: 2.00 },
    '4' => { name: 'Chocolate Shake', cost: 2.00 },
    '5' => { name: 'Strawberry Shake', cost: 2.00 }
  }
end