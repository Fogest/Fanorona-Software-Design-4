require 'spot'
require 'rule'
require 'player'

module Fanorona
  class Game
    VALID_OPTIONS = ['move', 'exit']
    def initialize(playerOneName, playerTwoName)
      @spots = Array.new(9) { Array.new(5) {Spot.new} }
      @players = [Player.new(playerOneName, @spots), Player.new(playerTwoName, @spots)]
      @turn = rand(2) #TODO: Turn should start with the "white" player according to rules.
      @currentPlayer = @players[@turn]
      @rules = Rule.new(3)

      #TODO: Put pieces in Spot's array
    end

    def startGame
      until !@rules.isWon(@spots).nil? or @rules.isDraw(@spots) do
        puts "#{@currentPlayer.name}'s turn"

        begin
          print '> '
          input = STDIN.gets.chomp
          tokens = input.split(' ')
        end until VALID_OPTIONS.include?(tokens[0])

        command = tokens[0].to_sym

        case command
          when :move
            if tokens.length != 4
              puts 'Invalid input'
              next
            elsif !%w(n ne e se s sw w).include?(tokens[3])
              puts 'Invalid direction provided.'
              next
            end

            x, y = tokens[1].to_i, tokens[2].to_i
            direction = tokens[3].to_sym

            # Validate the move
            # Move the piece
          when :exit
            puts 'Game is exiting.'
            exit
          else
        end

        # Only rotate to the next player if the player's move wasn't a capture
        @turn = ~@turn
        @currentPlayer = @players[@turn]
      end
      if @rules.checkEndGame(@spots)
        #Game is won
        puts "#{@rules.isWon(@spots).instance_variable_get(:@name)} has won the game!"
      else
        #Game is draw
        puts 'The game has ended in a draw!'
      end
    end
  end
end
