module Fanorona
  class Spot
    def initialize
      @piece = nil
    end

    def take
      @piece, piece = nil, @piece
      piece
    end

    def lookAtPiece
      @piece
    end

    def place(piece)
      @piece = piece
    end

    def isEmpty
      @piece.nil?
    end
  end
end