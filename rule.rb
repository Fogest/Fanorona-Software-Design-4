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
      if self.isDraw(spots)
        false
      end
      true
    end

    def isDraw(spot)
      if @drawTimer <= 0
        true
      end
      false
    end

    def isWon(spot)
      firstPlayer = nil
      secondPlayer = nil
      playerOnePieceCount = 0
      playerTwoPieceCount = 0
      spot.each_with_index do |x, xi|
        x.each_with_index do |y, yi|
          if spot[xi][yi].isEmpty
            next
          end

          if firstPlayer.nil?
            firstPlayer = spot[xi][yi].lookAtPiece.getPlayer
            playerOnePieceCount += 1
            next
          end

          if spot[xi][yi].lookAtPiece.getPlayer == firstPlayer
            playerOnePieceCount += 1
          else
            if secondPlayer.nil?
              secondPlayer = spot[xi][yi].lookAtPiece.getPlayer
            end
            playerTwoPieceCount += 1
          end
        end
      end

      if playerOnePieceCount == 1 and playerTwoPieceCount == 1
        @drawTimer -= 1
        nil
      elsif playerOnePieceCount > 0 and playerTwoPieceCount > 0
        nil
      elsif playerOnePieceCount <= 0
        secondPlayer
      elsif playerTwoPieceCount <= 0
        firstPlayer
      end
      nil
    end
  end
end