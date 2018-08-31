module Hand
  def add_one(card)
    cards.push(card)
  end

  def display_hand
    cards.each do |card|
      puts "#{card.face} of #{card.suit}: #{card.value}"
    end
  end

  def choose_action
    answer = nil

    puts "Do you want to hit or stay?"
    loop do
      answer = gets.chomp.downcase
      break if ['hit', 'stay'].include?(answer)
      puts "Sorry, that is not a valid answer. Try again."
    end
    self.action = answer
  end

  def hit?
    action == 'hit'
  end

  def stay?
    action == 'stay'
  end

  def twenty_one?
    value_total == 21
  end

  def complete_turn?
    stay? || bust? || twenty_one?
  end

  def bust?
    value_total > 21
  end

  def value_total
    total = 0
    not_aces.each { |card| total += card.value }

    aces.each do |card|
      as_one = total + card.value[0]
      as_eleven = total + card.value[1]
      total = as_eleven <= (21 - (aces.count - 1)) ? as_eleven : as_one
    end
    total
  end

  def not_aces
    cards.select { |card| card.value != [1, 11] }
  end

  def aces
    cards.select { |card| card.value == [1, 11] }
  end
end

class Participant
  include Hand

  attr_accessor :cards, :name, :action

  def initialize
    @cards = []
    @name = nil
    @action = nil
  end
end

class Player < Participant
  def set_name
    input = nil
    loop do
      puts "What is your name?"
      input = gets.chomp.capitalize
      break if (input.match("[a-zA-Z]+"))
      puts "Please type your name."
    end
    self.name = input
  end
end

class Dealer < Participant
  def set_name
    self.name = ['R2D2', 'Hal', 'GlaDOS'].sample
  end

  def display_initial
    puts "Hidden Card"
    puts "#{cards[1].face} of #{cards[1].suit}: #{cards[1].value}"
  end

  def choose_action
    self.action = if twenty_one?
                    'stay'
                  elsif value_total < 16
                    'hit'
                  else
                    'stay'
                  end
  end
end

class Deck
  SUITS = ['Clubs', 'Diamonds', 'Hearts', 'Spades']
  FACES = ['Ace', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight'] +
          ['Nine', 'Ten', 'Jack', 'Queen', 'King']
  VALUES = [[1, 11], 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10]

  attr_accessor :cards

  def initialize
    @cards = make_deck
  end

  def make_deck
    collection = []
    SUITS.each do |suit|
      FACES.each do |face|
        collection << Card.new(suit, face, VALUES[FACES.index(face)])
      end
    end
    collection.shuffle!
  end

  def deal_one
    cards.pop
  end
end

class Card
  attr_reader :suit, :face, :value

  def initialize(suit, face, value)
    @suit = suit
    @face = face
    @value = value
  end
end

class TwentyOne
  attr_accessor :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def start
    welcome_message
    player.set_name
    dealer.set_name
    loop do
      deal_cards
      show_flop
      player_turn
      unless player.bust?
        dealer_turn
      end
      display_winner
      break unless play_again?
      reset
    end
    valediction
  end

  private

  def welcome_message
    puts "Hello, and welcome to the Twenty-One Game!"
    puts ""
  end

  def deal_cards
    2.times do
      player.add_one(deck.deal_one)
      dealer.add_one(deck.deal_one)
    end
  end

  def show_flop
    system 'clear'
    puts ""
    puts "---#{player.name}'s Hand"
    player.display_hand
    puts ""
    puts "---Dealer #{dealer.name}'s Hand"
    dealer.display_initial
    puts ""
  end

  def show_both_hands
    system 'clear'
    puts ""
    puts "---#{player.name}'s Hand"
    player.display_hand
    puts ""
    puts "---Dealer #{dealer.name}'s Hand"
    dealer.display_hand
    puts ""
  end

  def player_turn
    loop do
      break if player.twenty_one?
      player.choose_action
      player.add_one(deck.deal_one) if player.hit?
      show_flop
      break if player.complete_turn?
    end
  end

  def dealer_turn
    loop do
      show_both_hands
      sleep 1
      break if dealer.twenty_one?
      dealer.choose_action
      dealer.add_one(deck.deal_one) if dealer.hit?
      show_both_hands
      break if dealer.complete_turn?
      sleep 1
    end
  end

  def player_loss?
    player.value_total < dealer.value_total
  end

  def dealer_loss?
    player.value_total > dealer.value_total
  end

  def display_winner
    show_both_hands
    show_scores
    if player.bust?
      puts "#{player.name} busted! Dealer #{dealer.name} wins."
    elsif dealer.bust?
      puts "Dealer #{dealer.name} busted! #{player.name} wins."
    elsif player_loss?
      puts "Dealer #{dealer.name} wins the hand."
    elsif dealer_loss?
      puts "#{player.name} wins the hand!"
    else
      puts "It's a push!"
    end
    puts ""
  end

  def show_scores
    puts "#{player.name}'s hand equals #{player.value_total} points. "
    puts "Dealer #{dealer.name}'s hand equals #{dealer.value_total} points."
    puts ""
  end

  def play_again?
    answer = nil
    puts "Do you want to play again? y/n"
    loop do
      answer = gets.chomp.downcase
      break if ['y', 'n'].include?(answer)
      puts "Please type y or n."
    end
    answer == 'y'
  end

  def reset
    new_deck if deck.cards.count < 10
    player.cards = []
    dealer.cards = []
  end

  def new_deck
    self.deck = Deck.new
  end

  def valediction
    puts "Thanks for playing the Twenty-One Game."
  end
end

game = TwentyOne.new
game.start
