module Fanorona
    class Piece
        def initialize(player)
            @captured = false
            @playerCallback = player
        end

        def getPlayer
            @playerCallback
        end

        def capture
            @captured = true
        end

        def isCaptured
            @captured
        end
      end
end