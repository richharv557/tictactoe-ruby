board_array = [1, 2, 3, 4, 5, 6, 7, 8, 9]

def welcome
  puts 'Welcome to Tic-Tac-Toe'
  puts "This is a player vs. player game. Player One will have X's, Player Two will have O's."
end

# need to add validation and while loop to player inputs
def player_1_input
  puts 'Player 1, please enter the number of the board-square you want to place your X.'
  gets.chomp.to_i - 1
end

def player_2_input
  puts 'Player 2, please enter the number of the board-square you want to place your O.'
  gets.chomp.to_i - 1
end

def update_board_state(board_state)
  board_state[player_1_input] = 'X'
end

class Board
  attr_accessor :board_state
  
  def initialize
    @board_state = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  end

  def show_board_state
    p board_state
  end

  def print_board
    puts("        
            |   |   
          #{board_state[0][0]} | #{board_state[0][1]} | #{board_state[0][2]} 
         ___|___|___
            |   |   
          #{board_state[1][0]} | #{board_state[1][1]} | #{board_state[1][2]} 
         ___|___|___
            |   |   
          #{board_state[2][0]} | #{board_state[2][1]} | #{board_state[2][2]} 
            |   |   ")
  end
end

new_board = Board.new
new_board.show_board_state
new_board.print_board
puts new_board.board_state.flatten.include?(5)