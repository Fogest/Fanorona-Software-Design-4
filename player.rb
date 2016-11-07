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

    def makeMove(source, destination)
      source_loc = Array.new(2)
      dest_loc = Array.new(2)
      y = 0

      while y < 5 do
        x = 0
        while x < 9 do
          if @spots[x][y] == source
            source_loc[0] = x
            source_loc[1] = y
          end

          if @spots[x][y] == destination
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

      approach_x = dest_loc[0] + direction[0]
      approach_y = dest_loc[1] + direction[1]

      withdraw_x = source_loc[0] - direction[0]
      withdraw_y = source_loc[1] - direction[1]

      #If numbers in range approaching and it is not the current players piece
      if (0..8) === approach_x && (0..4) === approach_y && @spots[approach_x][approach_y].lookAtPiece.getPlayer != self
        if self.makeCapture == true
          @spots[approach_x][approach_y].lookAtPiece.capture
        end
        continuous = true
        #Keep finding all until either out of range or it is no longer the opponents piece
        while continuous == true do
          approach_x = approach_x + direction[0]
          approach_y = approach_y + direction[1]

          if (0..8) === approach_x && (0..4) === approach_y && @spots[approach_x][approach_y].lookAtPiece.getPlayer != self
            if self.makeCapture == true
              @spots[approach_x][approach_y].lookAtPiece.capture
            end
          else
            continuous = false
          end

        end
      #Else if numbers in range withdrawing and it is not the current players piece
      elsif (0..8) === withdraw_x && (0..4) === withdraw_y && @spots[withdraw_x][withdraw_y].lookAtPiece.getPlayer != self
        if self.makeCapture == true
          @spots[withdraw_x][withdraw_y].lookAtPiece.capture
        end
        continuous = true
        while continuous == true do
          withdraw_x = withdraw_x - direction[0]
          withdraw_y = withdraw_y - direction[1]

          if (0..8) === withdraw_x && (0..4) === withdraw_y && @spots[withdraw_x][withdraw_y].lookAtPiece.getPlayer != self
            if self.makeCapture == true
              @spots[withdraw_x][withdraw_y].lookAtPiece.capture         
            end
          else
            continuous = false
          end

        end
      end

    end

    private
    def makeCapture
      true
    end
  end
end
