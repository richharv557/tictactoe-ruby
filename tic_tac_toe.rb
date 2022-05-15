# frozen_string_literal: true

# TicTacToe class represents the gameboard and the ongoing state of the game
class TicTacToe
  attr_accessor :board_state

  def initialize
    @board_state = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @keep_playing = true
    @game_over = false
    @player_list = []
  end

  # gamerunner, sets up 2 permanent players then plays a round. Keeping symbols fixed due to board-state check logic
  def play_game
    welcome
    player1 = Player.new('X')
    player2 = Player.new('O')
    while @keep_playing
      new_game = TicTacToe.new
      new_game.play_turns(player1, player2)
      ask_for_new_round
    end
  end

  # nested loop to play a turn and run checks for each player. Need to understand why this can't be private rn
  def play_turns(player1, player2)
    @player_list.push(player1, player2)
    loop do
      @player_list.each do |player|
        print_board
        player.input_move(self)
        update_board_state(player)
        if game_won
          print_board
          puts "#{player.name} wins!"
          player.wins += 1
          break
        end
        if game_drawn
          print_board
          puts 'Game drawn, nobody wins!'
          break
        end
      end
      break if @game_over == true
    end
    puts "#{player1.name} has won #{player1.wins} times, and #{player2.name} has won #{player2.wins} times."
  end

  private

  def welcome
    puts 'Welcome to Tic-Tac-Toe.'
    puts "This is a player vs. player game. Player 1 will have X's, Player 2 will have O's. Your goal is to connect 3 in a row. Good luck!"
  end

  def update_board_state(player_object)
    board_state[player_object.move - 1] = player_object.symbol
  end

  def game_won
    if board_state[0] == board_state[1] && board_state[1] == board_state[2]
      @game_over = true
    elsif board_state[3] == board_state[4] && board_state[4] == board_state[5]
      @game_over = true
    elsif board_state[6] == board_state[7] && board_state[7] == board_state[8]
      @game_over = true
    elsif board_state[0] == board_state[3] && board_state[3] == board_state[6]
      @game_over = true
    elsif board_state[1] == board_state[4] && board_state[4] == board_state[7]
      @game_over = true
    elsif board_state[2] == board_state[5] && board_state[5] == board_state[8]
      @game_over = true
    elsif board_state[0] == board_state[4] && board_state[4] == board_state[8]
      @game_over = true
    elsif board_state[2] == board_state[4] && board_state[4] == board_state[6]
      @game_over = true
    end
  end

  def game_drawn
    if board_state.all? { |i| i.is_a? String }
      @game_over = true
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
            |   |
            ")
  end

  def ask_for_new_round
    puts "Would you like to play again? Type 'y' for yes, anything else for no."
    unless gets.chomp == 'y'
      @keep_playing = false
    end
  end
end

# Player class has two instances made (currently the symbol is fixed for readability.)
class Player
  attr_reader :symbol, :name
  attr_accessor :move, :wins

  @@player_number = 1

  def initialize(symbol)
    @symbol = symbol
    @wins = 0
    @move = ''
    puts "Player #{@@player_number}, what is your name?"
    @name = gets.chomp
    @@player_number += 1
  end

  def input_move(tic_tac_toe_object)
    puts "#{name}, please enter the number of the board-square you want to place your #{symbol}."
    loop do
      input = gets.chomp.to_i
      if (input.is_a? Integer) && tic_tac_toe_object.board_state.flatten.include?(input)
        self.move = input
        break
      end
      puts "Invalid input. Please enter the number of the board-square you want to place your #{symbol}."
    end
  end
end

game = TicTacToe.new
game.play_game
