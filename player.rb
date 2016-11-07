require 'piece'
require 'rule'

module Fanorona
  class Player
    def initialize(name, spots)
      @name = name
      @spots = spots
      @pieces = Array.new(22) {Piece.new(self)}

      if @spots[0][0] == nil
        k = 0
        i = 0

        while i < 2 do
          j = 0
          while j < 9 do
            @spots[i][j] = @pieces[k]
            k += 1
            j += 1
          end
          i += 1
        end

        @spots[2][0] = @pieces[18]
        @spots[2][2] = @pieces[19]
        @spots[2][5] = @pieces[20]
        @spots[2][7] = @pieces[21]

      else

        @spots[2][1] = @pieces[0]
        @spots[2][3] = @pieces[1]
        @spots[2][6] = @pieces[2]
        @spots[2][8] = @pieces[3]

        k = 4
        i = 3

        while i < 5 do
          j = 0
          while j < 9 do
            @spots[i][j] = @pieces[k]
            k += 1
            j += 1
          end
          i += 1
        end

      end

    end

    def name
      @name
    end

    def makeMove(source, destination)


    end

    private
    def makeCapture


    end
  end
end
