require 'spot'
require 'rule'
require 'player'

module Fanorona
  class Game
    def initialize(playerOneName, playerTwoName)
      @spots = Array.new(9) { Array.new(5) {Spot.new} }
      @players = [Player.new(playerOneName, @spots), Player.new(playerTwoName, @spots)]
      @turn = rand(2) #TODO: Turn should start with the "white" player according to rules.
      @currentPlayer = @players[@turn]
      @rules = Rule.new(3)

      #TODO: Put pieces in Spot's array
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
