require 'pry'

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  # rubocop:disable Metrics/LineLength
  def find_at_risk_square
    square = nil

    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if two_human_markers?(squares)
        square = @squares.select { |k, v| line.include?(k) && v.marker == Square::INITIAL_MARKER }.keys.first
        break
      else
        square = nil
      end
    end
    square
  end

  def find_opportunity_square
    square = nil

    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if two_computer_markers?(squares)
        square = @squares.select { |k, v| line.include?(k) && v.marker == Square::INITIAL_MARKER }.keys.first
        break
      else
        square = nil
      end
    end
    square
  end

  def link_squares
    square = nil

    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if one_computer_marker?(squares)
        square = @squares.select { |k, v| line.include?(k) && v.marker == Square::INITIAL_MARKER }.keys.sample
        break
      else
        square = nil
      end
    end
    square
  end

  def one_computer_marker?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    markers.count(TTTGame::COMPUTER_MARKER) == 1 && markers.count(Square::INITIAL_MARKER) == 2
  end

  def two_human_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    markers.count(TTTGame::HUMAN_MARKER) == 2 && markers.count(Square::INITIAL_MARKER) == 1
  end

  def two_computer_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    markers.count(TTTGame::COMPUTER_MARKER) == 2 && markers.count(Square::INITIAL_MARKER) == 1
  end
  # rubocop:enable Metrics/LineLength

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
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
  FIRST_TO_MOVE = HUMAN_MARKER

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_marker = FIRST_TO_MOVE
    @five_games = [[], []]
  end

  def play
    clear
    display_welcome_message
    choose_first_player

    loop do
      display_board

      loop do
        current_player_moves
        break if board.someone_won? || board.full?
        clear_screen_and_display_board
      end

      display_result
      five_game_winner
      break unless play_again?
      reset
      display_play_again_message
    end

    display_goodbye_message
  end

  private

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def choose_first_player
    answer = nil
    loop do
      puts "Do you want to move first, or for the computer to go first? Type " \
         "'me', 'computer', or nothing, and press enter."
      answer = gets.chomp.downcase
      break if ['me', 'computer', ''].include?(answer)
      puts "That is not a valid reply, please try again."
    end

    @current_marker = case answer
                      when 'me'
                        HUMAN_MARKER
                      when 'computer'
                        COMPUTER_MARKER
                      else
                        [HUMAN_MARKER, COMPUTER_MARKER].sample
                      end
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def display_board
    puts "You're a #{human.marker}. Computer is a #{computer.marker}."
    puts ""
    board.draw
    puts ""
  end

  def joinor(array, punc=', ', link='or')
    if array.length > 2
      local_array = array
      last_number = local_array.pop
      "#{local_array.join(punc)} #{link} #{last_number}"
    elsif array.length == 2
      "#{array.first} #{link} #{array.last}"
    else
      array.first.to_s
    end
  end

  def current_player_moves
    if @current_marker == HUMAN_MARKER
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end

  def human_moves
    puts "Choose a square (#{joinor(board.unmarked_keys, '; ', 'and')}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def computer_moves
    square = board.find_opportunity_square

    if !square
      square = board.find_at_risk_square
    end

    if !square && board.unmarked_keys.include?(5)
      square = 5
    end

    if !square
      square = board.link_squares
    end

    if !square
      square = board.unmarked_keys.sample
    end

    board[square] = computer.marker
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts "You won!"
    when computer.marker
      puts "Computer won!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w[y n].include? answer
      puts "Sorry, must be y or n"
    end

    answer == 'y'
  end

  def clear
    system "clear"
  end

  def reset
    board.reset
    @current_marker = FIRST_TO_MOVE
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end

  def five_game_count
    if board.winning_marker == HUMAN_MARKER
      @five_games[0].push(board.winning_marker)
    elsif board.winning_marker == COMPUTER_MARKER
      @five_games[1].push(board.winning_marker)
    end
  end

  def reset_game_count
    @five_games = [[], []]
  end

  def five_game_winner
    five_game_count
    if @five_games[0].length == 5
      puts "You won five games!"
      reset_game_count
    elsif @five_games[1].length == 5
      puts "Computer won five games!"
      reset_game_count
    end
  end
end

game = TTTGame.new
game.play
