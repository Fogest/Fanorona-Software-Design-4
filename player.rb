require 'piece'

module Fanorona
  class Player
    def initialize(name, spots)
      @name = name
      @spots = spots
      @pieces = Array.new(22) {Piece.new(self)}

      if @spots[0][0].lookAtPiece.nil?
        k = 0
        i = 0

        while i < 2 do
          j = 0
          while j < 9 do
            @spots[j][i].place(@pieces[k])
            k += 1
            j += 1
          end
          i += 1
        end

        @spots[0][2].place(@pieces[18])
        @spots[2][2].place(@pieces[19])
        @spots[5][2].place(@pieces[20])
        @spots[7][2].place(@pieces[21])

      else

        @spots[1][2].place(@pieces[0])
        @spots[3][2].place(@pieces[1])
        @spots[6][2].place(@pieces[2])
        @spots[8][2].place(@pieces[3])

        k = 4
        i = 3

        while i < 5 do
          j = 0
          while j < 9 do
            @spots[j][i].place(@pieces[k])
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
      i = 0
      j = 0
      source_loc = Array.new(2)
      dest_loc = Array.new(2)

      while y < 5 do
        while x < 9 do
          if @spots[j][i] == source
            source_loc[0] = x
            source_loc[1] = y
          end

          if @spots[j][i] == destination
            dest_loc[0] = x
            dest_loc[1] = y
          end
          x += 1
        end
        y += 1
      end

      destination.place(source.take)

      direction = Array.new(2)

      if source_loc[1]==dest_loc[1]

        if source_loc[0]<dest_loc[0]
          direction = [1,0] #right
        else
          direction = [-1,0]  #left
        end

      elsif source_loc[1]<dest_loc[1]

        if source_loc[0]<dest_loc[0]
          direction = [1,1] #down-right
        elsif source_loc[0]>dest_loc[0]
          direction = [-1,1]  #down-left
        else
          direction = [0,1] #down
        end

      else

        if source_loc[0]<dest_loc[0]
          direction = [1,-1]  #up-right
        elsif source_loc[0]>dest_loc[0]
          direction = [-1,-1] #up-left
        else
          direction = [0,-1]  #up
        end
      end



    end

    private
    def makeCapture


    end
  end
end
