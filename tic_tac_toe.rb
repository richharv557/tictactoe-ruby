class Board
  attr_accessor :board_state

  def initialize
    @board_state = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def check_if_valid_input?(input)
    (input.is_a? Integer) && board_state.flatten.include?(input)
  end

  def update_board_state(input)
    board_state[input.to_i - 1] = 'X'
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
  def welcome
    puts 'Welcome to Tic-Tac-Toe.'
    puts "This is a player vs. player game. Player One will have X's, Player Two will have O's."
  end

  def ask_for_new_round?
    puts 'Would you like to play again? Type y for yes, anything else for no.'
    gets.chomp == 'y'
  end
end

# I'm not sure I want to initialize the player object each time...

class Player1
  attr_accessor :player_1_input

  def initialize
    puts 'Player 1, please enter the number of the board-square you want to place your X.'
    @player_1_input = gets.chomp.to_i
  end
end

class Player2
  attr_accessor :player_2_input

  def initialize
    puts 'Player 2, please enter the number of the board-square you want to place your O.'
    @player_2_input = gets.chomp.to_i
  end
end

new_game = Game.new
new_game.welcome
new_board = Board.new
new_board.print_board
p1_move = Player1.new.player_1_input
if new_board.check_if_valid_input?(p1_move)
  new_board.update_board_state(p1_move)
else 

end

p new_board.board_state

new_board.print_board
