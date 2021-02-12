require_relative 'player'
require_relative 'board'
class Controller
    def initialize()
        puts "Welcome to Connect Four"
        player1 = Player.new(getPlayerNames,"⚫")
        player2 = Player.new(getPlayerNames,"⚪")
        @gameBoard = Board.new()
        puts @gameBoard   
        turn_switcher(player1,player2)
        @gameBoard = Board.new()
    end 

    def make_move(player, messgage = "")
        (messgage == "") ? (puts "#{player.name} Please Select a Column") : (puts messgage)
        move_input = (gets.chomp)

        if(['1','2','3','4','5','6','7']).include?(move_input)
            if (@gameBoard.column_empty?(move_input.to_i))
                @gameBoard.drop_element(player.symbol,move_input.to_i)
                puts @gameBoard
            else
                make_move(player,"Sorry #{player.name} That Column is Full")
            end
        else
            make_move(player,"That is Not a Valid Column Entry")
        end    
    end
    def getPlayerNames()
        puts "Please enter a player name"
        name = (gets.chomp)
        return name
    end

    def turn_switcher(player1,player2)
        while (@gameBoard.check_for_full_board() == false)
            make_move(player1)
            if(@gameBoard.check_win(player1))
                puts "#{player1.name} wins!"
                break
            end
            make_move(player2)
            if(@gameBoard.check_win(player2))
                puts "#{player2.name} wins!"
                break
            end
        end
        if(@gameBoard.check_for_full_board())
            puts "Game Over: No one wins!"
        end
    end
end
a = Controller.new()
