module Fanorona
    class Piece
        @captured = false
        @playerCallback = nil

        def initialize(player)
            @playerCallback = player
        end

        def getPlayer()
            return @playerCallback
        end

        def capture()
            @captured = true
        end

        def isCaptured()
            return @captured
        end

      end
end