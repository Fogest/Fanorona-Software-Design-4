require 'spot'
require 'rule'
require 'player'

module Fanorona
  class Game
    VALID_OPTIONS = ['move', 'exit']

    def initialize(playerOneName, playerTwoName)
      @spots = Array.new(5) { Array.new(9) { Spot.new } }
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
            elsif !%w(n ne e se s sw w nw).include?(tokens[3])
              puts 'Invalid direction provided.'
              next
            end

            x, y = tokens[1].to_i, tokens[2].to_i
            direction = tokens[3]

            if %w(ne se sw nw).include?(direction) && (x % 2 == 0) != (y % 2 == 0)
              puts 'You can only move diagonally at strong intersections.'
              next
            end

            targetx, targety = x, y
            direction.split('').each { |d|
              dirIncr = case d
                          when 'n'
                            [0, -1]
                          when 's'
                            [0, 1]
                          when 'e'
                            [1, 0]
                          when 'w'
                            [-1, 0]
                          else
                            [0, 0]
                        end
              targetx += dirIncr[0]
              targety += dirIncr[1]
            }

            if targetx < 0 || targetx > 4 || targety < 0 || targety > 8
              puts 'Invalid move.'
              next
            end


          if @rules.checkMoveValidity(@currentPlayer, @spots[x][y], @spots[targetx][targety])
            @currentPlayer.makeMove(@spots[x][y], @spots[targetx][targety])
          end
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
