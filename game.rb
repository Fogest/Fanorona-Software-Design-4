require 'spot'
require 'rule'
require 'player'

module Fanorona
  class Game
    def initialize(playerOneName, playerTwoName)
      @spots = Array.new(9) { Array.new(5) }
      @players = [Player.new(playerOneName, @spots), Player.new(playerTwoName, @spots)]
      @currentPlayer = @players[0]
      @rules = Rule.new(1)
    end

    def startGame

    end
  end
end