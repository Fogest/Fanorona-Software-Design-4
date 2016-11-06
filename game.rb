require 'spot'
require 'rule'
require 'player'

module Fanorona
  class Game
    def initialize(playerOneName, playerTwoName)
      @spots = Array.new(9) { Array.new(5) }
      @players = [Player.new(playerOneName, @spots), Player.new(playerTwoName, @spots)]
      @turn = rand(2)
      @currentPlayer = @players[@turn]
      @rules = Rule.new(1)
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
