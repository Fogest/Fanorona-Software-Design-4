require 'spot'
require 'rule'
require 'player'

module Fanorona
  class Game
    VALID_OPTIONS = ['move', 'display', 'help', 'exit']

    def initialize(playerOneName, playerTwoName)
      @spots = Array.new(9) { Array.new(5) { Spot.new } }
      @players = [Player.new(playerOneName, @spots), Player.new(playerTwoName, @spots)]
      @turn = 1 #"white player"
      @currentPlayer = @players[@turn]
      @rules = Rule.new(3)

    end

    def startGame
      displayBoard
      puts
      displayOptions
      puts

      until !@rules.isWon(@spots).nil? or @rules.isDraw(@spots) do
        puts "#{@currentPlayer.instance_variable_get('@name')}'s turn"

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

            if targetx < 0 || targetx > 8 || targety < 0 || targety > 4
              puts 'Invalid move out of bounds.'
              next
            end

            if @rules.checkMoveValidity(@currentPlayer, @spots[x][y], @spots[targetx][targety])
              # Move the piece
              @currentPlayer.makeMove(@spots[x][y], @spots[targetx][targety])

              # Only rotate to the next player if the player's move was valid and not a capture
              @turn = ~@turn
              @currentPlayer = @players[@turn]
              displayBoard
            else
              puts 'Invalid move.'
            end
          when :display
            displayBoard
          when :help
            displayOptions
          when :exit
            puts 'Goodbye thank you for playing.'
            exit
          else
        end
        puts
      end

      if @rules.checkEndGame(@spots)
        #Game is won
        puts "#{@rules.isWon(@spots).instance_variable_get('@name')} has won the game!"
      else
        #Game is draw
        puts 'The game has ended in a draw!'
      end
    end

    private
    def displayOptions
      puts 'Please choose a command'
      puts 'move [x] [y] [direction] - Moves the piece at x, y in the given direction (one of n, ne, e, se, s, sw, w, nw)'
      puts 'help                     - Displays the menu options'
      puts 'display                  - Displays the game board'
      puts 'exit                     - Exits the game'
    end

    def displayBoard
      diagDir = 0
      y = 0

      puts '  ' + (0..8).map { |i|
        i.to_s
      }.join(' ')

      while y < 5
        line = ''
        connections = ''
        x = 0
        while x < 9
          spot = @spots[x][y]
          if spot.lookAtPiece.nil? || spot.lookAtPiece.isCaptured
            line += '-'
          elsif @players.index(spot.lookAtPiece.getPlayer) == 0
            line += 'O'
          else
            line += 'X'
          end

          connections += '|'

          if x < 8
            line += '-'
            connections += ['\\', '/'][diagDir]
          end

          diagDir = ~diagDir
          x += 1
        end
        print y, ' '
        puts line

        if y < 4
          print '  '
          puts connections
        end
        y += 1
      end
    end
  end
end
