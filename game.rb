require 'spot'
require 'rule'
require 'player'

module Fanorona
  class Game
    def initialize(playerOneName, playerTwoName)
      @spots = Array.new(9) { Array.new(5) }
      @players = [Player.new(playerOneName, @spots), Player.new(playerTwoName, @spots)]
      @turn = rand(2) #TODO: Turn should start with the "white" player according to rules.
      @currentPlayer = @players[@turn]
      @rules = Rule.new(1)

      #TODO: Populate spot array with Spot objects and the Piece's to go in the correct spots for game start.
    end

    def startGame
      until @rules.checkEndGame(@spots) do


        # Give the next player their turn
        @turn = ~@turn
        @currentPlayer = @players[@turn]
      end
    end
  end
end
