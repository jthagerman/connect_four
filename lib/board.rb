class Board

    def initialize()
        @board =  Array.new(6) { Array.new(7) }
        


    end

    def getBoard()
        return @board
    end

    def checkPosition(row,col)
        (@board[row-1][col-1] == nil)?  true :  false  
    end
    def getPosition(row,col)
        return @board[row][col]
    end

    def checkValidPosition(row,col)
        begin
            if((row <1)||(row>6) ||(col < 1)||(col>7))
                raise OffBoard.new "Invalid Pos"
            end
        rescue OffBoard => e
            puts "Error! This is off the board"
            return false
        end
        return true

    end

    def to_s
        board_string = "_______________\n"
        @board.each_with_index do |column, index|
            row_string = ""
            column.each_with_index do |row,index2|
                if(row == nil)
                    row_string += "| "
                else
                    row_string += "|#{row}"
                end
            end
            row_string += "|\n"
            board_string += row_string
        end
        board_string += "=1=2=3=4=5=6=7=\n"
        return board_string
    end
end

class OffBoard < StandardError
    def initialize(msg="Pos is off the board", exception_type="custom")
      @exception_type = exception_type
      super(msg)
    end
  end

a = Board.new()
puts a.to_s
a.checkValidPosition(0,0)
a.checkValidPosition(100,1100)
puts a.checkValidPosition(2,2)