module Fanorona
  class Rule
    def initialize(drawTimer)
      @drawTimer = drawTimer
    end

    def checkMoveValidity(currentPlayer, source, destination)
      if destination.isEmpty and source.lookAtPiece.getPlayer == currentPlayer
        #Piece is owned by current player, and the destination is empty.
        destination.place(source.take)
        true
      end

      false
    end

    def checkEndGame(spots)
      #Used to check if next piece found is the same player. If they are different
      # then the game is not over as both players still have pieces.
      firstFoundPlayer = nil
      foundTwoPlayers = false
      playerOnePieceCount = 0
      playerTwoPieceCount = 0
      spots.each_with_index do |x, xi|
        x.each_with_index do |y, yi|
          if spots[xi][yi].isEmpty
            next
          end

          if firstFoundPlayer.nil?
            firstFoundPlayer = spots[xi][yi].lookAtPiece.getPlayer
            playerOnePieceCount += 1
            next
          end

          if spots[xi][yi].lookAtPiece.getPlayer == firstFoundPlayer
            playerOnePieceCount += 1
            next
          else
            playerTwoPieceCount += 1
            foundTwoPlayers = true
          end
        end
      end
      if foundTwoPlayers
        if playerOnePieceCount == 1 and playerTwoPieceCount == 1
          @drawTimer -= 1
        end
        return isDraw(spots)
      end

      true
    end

    private
    def isDraw(spot)
      if @drawTimer <= 0
        true
      end
      false
    end

    private
    def isWon(spot)
      #Useless function, we don't care who wins, we need to check if there is a win, and then
      # have something that can say WHO won. Since this is a private function we don't need to
      # know the who in it.
    end
  end
end