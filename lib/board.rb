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

    def check_for_full_board()
        @board.each_with_index do |row, rowIndex|
            row.each_with_index do |column, colIndex|
                if( @board[rowIndex][colIndex] == nil)
                    return false
                end
            end
        end
        return true
    end

    def check_win(player)
        player = player.symbol
        win_array = [player,player,player,player] 
        #verticals
        column_array = Array.new(7)  { Array.new(6) }
        @board.each_with_index do |row, row_index|
            row.each_with_index do |col,col_index|
                column_array[col_index][row_index] = col
            end
        end
        column_array.each_with_index do |row, row_index| 
            if ((row[0..3] == win_array) ||
                  (row[1..4] == win_array) ||
                  (row[2..5] == win_array))
                   puts "verticsl win"
                    return true
             end
        end
        #check horizontals
        @board.each_with_index do |row, row_index| 
           if ((row[0..3] == win_array) ||
                 (row[1..4] == win_array) ||
                 (row[2..5] == win_array) ||
                 (row[3..6] == win_array))
                puts "horiz win"
                 return true
            end
        end
        #verticals
        @board.each_with_index do |row, row_index|
            row.each_with_index do |col,col_index|
                if @board[row_index][col_index] == player && @board[row_index-1][col_index+1] == player &&
                     @board[row_index-2][col_index+2] == player && @board[row_index-3][col_index+3] == player
                     puts "diagona top to bottom win"
                    return true
                end
            end
        end
        @board.each_with_index do |row, row_index|
            row.each_with_index do |col,col_index|
                if @board[row_index][col_index] == player && @board[row_index-1][col_index-1] == player &&
                     @board[row_index-2][col_index-2] == player && @board[row_index-3][col_index-3] == player
                     puts "diaginal bottom to top win"
                    return true
                end
            end
        end
        return false
    end

    def drop_element(symbol,column)
        column = column-1
        row_count = (@board.length) -1
        while(row_count >= 0)
            if(@board[row_count][column]).is_a?(NilClass)
                @board[row_count][column] = symbol
                break
            end
            row_count -= 1
        end
    end

    def column_empty?(col)
        col = col - 1
        @board.each_with_index do |row, index|      
            row.each_with_index do |column, index2|
                if(index2 == col)
                    if column == nil
                        return true
                    end
                end
            end
        end
        return false
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
        board_string = "______________________\n"
        @board.each_with_index do |column, index|
            row_string = ""
            
            column.each_with_index do |row,index2|
                if(row == nil)
                    row_string += "|  "
                else
                    row_string += "|#{row}"
                end
            end
            row_string += "|\n"
            board_string += row_string
        end
        board_string += "=1==2==3==4==5==6==7==\n"
        return board_string
    end
end

class OffBoard < StandardError
    def initialize(msg="Pos is off the board", exception_type="custom")
        @exception_type = exception_type
        super(msg)
    end
end

