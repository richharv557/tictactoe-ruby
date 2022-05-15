# frozen_string_literal: true

# TicTacToe class represents the gameboard and the ongoing state of the game
class TicTacToe
  attr_accessor :board_state

  def initialize
    @board_state = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @keep_playing = true
    @game_over = false
    @player_list = []
    @WINNING_COMBINATIONS = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ]
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

  protected

  # nested loop to play a turn and run checks for each player.
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
    puts "#{player1.name} has won #{player1.wins} times, and #{player2.name} has won #{player2.wins} times.\n\n"
  end

  private

  def welcome
    puts '|+++++++++++++++++++++++++++++|'
    puts '|++++++++ TIC-TAC-TOE ++++++++|'
    puts '|+++++++++++++++++++++++++++++|'
    puts ''
    puts 'Welcome to Tic-Tac-Toe. The game of CHAMPS.'
    puts ''
    puts "This is a player vs. player game. Player 1 has X's, Player 2 has O's. Connect 3 in a row! Good luck!"
  end

  def update_board_state(player_object)
    board_state[player_object.move - 1] = player_object.symbol
  end

  def game_won
    @WINNING_COMBINATIONS.each do |combination|
      test_array = []
      combination.each do |number|
        test_array.push(board_state[number])
      end
      if test_array == ['X', 'X', 'X'] || test_array == ['O', 'O', 'O']
        @game_over = true
        return true
      end
    end
    false
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

# Player class has two instances made (currently the symbol is fixed for readability and draw status check.)
class Player
  attr_reader :symbol, :name
  attr_accessor :move, :wins

  @@player_number = 0

  def initialize(symbol)
    @symbol = symbol
    @wins = 0
    @move = ''
    @@player_number += 1
    puts "Player #{@@player_number}, what is your name?"
    @name = gets.chomp
  end

  def input_move(tic_tac_toe_object)
    puts "#{name}, please enter the number of the board-square where you want to place your #{symbol}."
    loop do
      input = gets.chomp.to_i
      if (input.is_a? Integer) && tic_tac_toe_object.board_state.flatten.include?(input)
        self.move = input
        break
      end
      puts "Invalid input. Please enter the number of the board-square where you want to place your #{symbol}."
    end
  end
end

game = TicTacToe.new
game.play_game
