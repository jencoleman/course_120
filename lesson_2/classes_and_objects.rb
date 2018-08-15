#Question1, 2

class Person
  attr_accessor :first_name :last_name
  
  
  def initialize(input)
    parse_full_name(input)
  end
  
  def name
    "#{first_name} #{last_name}".strip
  end
  
  def name=(input)
    parse_full_name(input)
  end
  
  protected
  
  def parse_full_name(input)
    parts = input.split
    self.first_name = parts.first
    self.last_name = parts.size > 2 ? parts.last : ''
  end
end

bob = Person.new('bob')
bob.name                  # => 'bob'
bob.name = 'Robert'
bob.name                  # => 'Robert'

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

bob.name == rob.name



