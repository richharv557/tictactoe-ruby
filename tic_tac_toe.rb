# frozen_string_literal: true
# consider how to playerswap and loop that (each maybe?)
# my classes are way too blended together I need to figure out how to separate them in the methods more
# I also need to get the play game functionality mostly embedded in my TicTacToe class rather than just floating outside.


class TicTacToe
  attr_accessor :board_state, :keep_playing

  def welcome
    puts 'Welcome to Tic-Tac-Toe.'
    puts "This is a player vs. player game. Player One will have X's, Player Two will have O's."
  end

  def initialize
    @board_state = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @keep_playing = true
  end

  def play_game
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

  def ask_for_new_round?
    puts 'Would you like to play again? Type y for yes, anything else for no.'
    gets.chomp == 'y'
  end
end

class Player
  attr_reader :symbol, :name
  attr_accessor :move

  def initialize(name, symbol)
    @symbol = symbol
    @name = name
    @move = ''
  end

  def input_move(object)
    puts "#{name}, please enter the number of the board-square you want to place your #{symbol}."
    loop do
      input = gets.chomp.to_i
      if (input.is_a? Integer) && object.board_state.flatten.include?(input)
        self.move = input
        break
      end
      puts "Invalid input. Please enter the number of the board-square you want to place your #{symbol}."
    end
  end
end


new_game = TicTacToe.new
new_game.welcome
while new_game.keep_playing do
  new_game = TicTacToe.new
  player1 = Player.new('Player 1', 'X')
  player2 = Player.new('Player 2', 'O')
  loop do
    new_game.print_board
    player1.input_move(new_game)
    new_game.update_board_state(player1)
    if new_game.check_if_game_won
      new_game.print_board
      puts "Player 1 wins!"
      break
    end
    if new_game.check_if_game_drawn
      new_game.print_board
      puts 'Game drawn, nobody wins!'
      break
    end
    new_game.print_board
    player2.input_move(new_game)
    new_game.update_board_state(player2)
    if new_game.check_if_game_won
      new_game.print_board
      puts 'Player 2 wins!'
      break
    end
    if new_game.check_if_game_drawn
      new_game.print_board
      puts 'Game drawn, nobody wins!'
      break
    end
  end
  new_game.ask_for_new_round? ? new_game.keep_playing = true : new_game.keep_playing = false
end