class Board
  attr_accessor :board_state, :game_won

  def initialize
    @board_state = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @game_won = false
    print_board
  end

  def check_if_valid_input?(object)
    (object.move.is_a? Integer) && board_state.flatten.include?(object.move)
  end

  def update_board_state(object)
    board_state[object.move - 1] = object.symbol
  end

  def check_if_game_won
    if board_state[0] == board_state[1] && board_state[1] == board_state[2]
      @game_won = true
    end
  end

  def print_board
    puts("        
            |   |   
          #{board_state[0]} | #{board_state[1]} | #{board_state[2]} 
         ___|___|___
            |   |   
          #{board_state[3]} | #{board_state[4]} | #{board_state[5]} 
         ___|___|___
            |   |   
          #{board_state[6]} | #{board_state[7]} | #{board_state[8]} 
            |   |   ")
  end
end

class Game
  def initialize
    puts 'Welcome to Tic-Tac-Toe.'
    puts "This is a player vs. player game. Player One will have X's, Player Two will have O's."
  end

  def ask_for_new_round?
    puts 'Would you like to play again? Type y for yes, anything else for no.'
    gets.chomp == 'y'
  end
end

class Player1
  attr_accessor :move, :symbol

  def initialize
    @symbol = 'X'
  end
  def input_move
    puts 'Player 1, please enter the number of the board-square you want to place your X.'
    @move = gets.chomp.to_i
  end
end

class Player2
  attr_accessor :move, :symbol

  def initialize
    @symbol = 'O'
  end

  def input_move
    puts 'Player 2, please enter the number of the board-square you want to place your O.'
    @move = gets.chomp.to_i
  end
end

new_game = Game.new
new_board = Board.new
player_1 = Player1.new
player_2 = Player2.new

player_1.input_move
if new_board.check_if_valid_input?(player_1)
  new_board.update_board_state(player_1)
  new_board.check_if_game_won
end
new_board.print_board
player_2.input_move
if new_board.check_if_valid_input?(player_2)
  new_board.update_board_state(player_2)
  new_board.check_if_game_won
end

p new_board.board_state

new_board.print_board
