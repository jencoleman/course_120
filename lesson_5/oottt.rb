require 'pry'

class Board
  INITIAL_MARKER = " "
  def initialize
    @squares = {}
    (1..9).each {|key| @squares[key] = Square.new(INITIAL_MARKER) }
  end
  
  def get_square_at(key)
    @squares[key]
  end
  
  def set_square_at(key, marker)
    @squares[key] = marker
  end
  
  def unmarked_keys
    @squares.select {|k, v| v.unmarked? }.keys
  end

end

class Square
  attr_reader :marker
  
  def initialize(marker)
    @marker = marker
  end
  
  def to_s
    marker
  end
  
  def unmarked?
    return true if @marker == Board::INITIAL_MARKER
    return false if @marker == TTTGame::HUMAN_MARKER
    return false if @marker == TTTGame::COMPUTER_MARKER
  end
end

class Player
  attr_reader :marker
  
  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"
  
  attr_reader :board, :human, :computer
  
  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
  end
  
  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts
  end
  
  def human_moves
    square = nil
    
    puts "Choose a square: #{board.unmarked_keys.join(', ')}: "
    loop do
      square = gets.chomp.to_i
      break if (1..9).include?(square)
      puts "Sorry, that's not a valid choice."
    end
    board.set_square_at(square, human.marker)
  end
  
  def computer_moves
    board.set_square_at(rand(10), computer.marker)
  end
  
  def display_board(board)
    puts ""
    puts "     |     |"
    puts "  #{board.get_square_at(1)}  |  #{board.get_square_at(2)}  |  #{board.get_square_at(3)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{board.get_square_at(4)}  |  #{board.get_square_at(5)}  |  #{board.get_square_at(6)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{board.get_square_at(7)}  |  #{board.get_square_at(8)}  |  #{board.get_square_at(9)}"
    puts "     |     |"
  end
  
  def play
    display_welcome_message
    display_board(board)
    loop do
      human_moves
      #break if someone_won? || board_full?
    
      computer_moves
      #break if someone_won? || board_full?
      display_board(board)
    end
    display_result?
    display_goodbye_message
  end
end

game = TTTGame.new
game.play
