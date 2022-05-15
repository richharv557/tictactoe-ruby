class Board
  attr_accessor :board_state, :game_won, :game_drawn

  def initialize
    @board_state = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @game_won = false
    @game_drawn = false
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
    elsif board_state[3] == board_state[4] && board_state[4] == board_state[5]
      @game_won = true
    elsif board_state[6] == board_state[7] && board_state[7] == board_state[8]
      @game_won = true
    elsif board_state[0] == board_state[3] && board_state[3] == board_state[6]
      @game_won = true
    elsif board_state[1] == board_state[4] && board_state[4] == board_state[7]
      @game_won = true
    elsif board_state[2] == board_state[5] && board_state[5] == board_state[8]
      @game_won = true
    elsif board_state[0] == board_state[4] && board_state[4] == board_state[8]
      @game_won = true
    elsif board_state[2] == board_state[4] && board_state[4] == board_state[6]
      @game_won = true
    end
  end

  def check_if_game_drawn
    if board_state.all? { |i| i.is_a? String }
      @game_drawn = true
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
  attr_accessor :keep_playing
  
  def initialize
    @keep_playing = true
    puts 'Welcome to Tic-Tac-Toe.'
    puts "This is a player vs. player game. Player One will have X's, Player Two will have O's."
  end

  def ask_for_new_round?
    puts 'Would you like to play again? Type y for yes, anything else for no.'
    gets.chomp == 'y'
  end
end

class Player1
  attr_reader :move, :symbol

  def initialize
    @symbol = 'X'
  end
  def input_move
    puts 'Player 1, please enter the number of the board-square you want to place your X.'
    @move = gets.chomp.to_i
  end
end

class Player2
  attr_reader :move, :symbol

  def initialize
    @symbol = 'O'
  end

  def input_move
    puts 'Player 2, please enter the number of the board-square you want to place your O.'
    @move = gets.chomp.to_i
  end
end

# still need to validate player input and reloop if invalid
# DRY i think I can make an array with both players and enumerate over each instead of what i did here

new_game = Game.new
while new_game.keep_playing do
  new_board = Board.new
  player1 = Player1.new
  player2 = Player2.new
  loop do
    player1.input_move
    if new_board.check_if_valid_input?(player1)
      new_board.update_board_state(player1)
      if new_board.check_if_game_won
        new_board.print_board
        puts "Player 1 wins!"
        break
      end
      if new_board.check_if_game_drawn
        new_board.print_board
        puts 'Game drawn, nobody wins!'
        break
      end
    end
    new_board.print_board
    player2.input_move
    if new_board.check_if_valid_input?(player2)
      new_board.update_board_state(player2)
      if new_board.check_if_game_won
        new_board.print_board
        puts 'Player 2 wins!'
        break
      end
      if new_board.check_if_game_drawn
        new_board.print_board
        puts 'Game drawn, nobody wins!'
        break
      end
    end
    new_board.print_board
  end
  new_game.ask_for_new_round? ? new_game.keep_playing = true : new_game.keep_playing = false
end