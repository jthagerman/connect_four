#/lib/controller
require_relative 'player'
require_relative 'board'
require 'json'

class Controller
    def initialize(player1 =nil, player2=nil,gameBoard=nil,current_turn=nil)

        if(player1==nil)
            @player1 = Player.new(getPlayerNames,"⚫")
            @player2 = Player.new(getPlayerNames,"⚪")
            @current_turn = player1
            puts "Type save anytime to save the game, quit to quit"
            @gameBoard = play_game(@player1, @player2)
        else
            puts "Welcome Back"
            @player1 = player1
            @player2 = player2
            @gameBoard = gameBoard
            @current_turn = current_turn
            resume_game(@player1,@player2,@currentTurn,@gameBoard)       
        end
    end
    def to_json
        JSON.dump ({
          :player1 => @player1.to_json,
          :player2 => @player2.to_json,
          :gameBoard => @gameBoard.to_json,
          :current_turn => @current_turn.to_json
        })
    end

    def self.from_json(string)
        data = JSON.load string
        self.new(Player.from_json(data['player1']), Player.from_json(data['player2']),Board.from_json(data['gameBoard']), Player.from_json(data['current_turn']))
    end
    def resume_game(player1,player2,current_turn,board)
        keep_playing = true
        @gameBoard = board   
        while(keep_playing)
            puts @gameBoard       
            if(current_turn == player1)
                turn_switcher(player1 ,player2)
            else
                turn_switcher(player2 ,player1)
            end
            puts "#{player1.name} has won #{player1.wins} games"
            puts "#{player2.name} has won #{player2.wins} games"
            @gameBoard = Board.new()

            puts "\nType yes to start a new game or any key to exit\n"
            continue = gets.chomp.downcase
            if continue != "yes"
                quit()
            end
        end
    end

    def play_game(player1 ,player2)
        keep_playing = true
        while(keep_playing)
            @gameBoard = Board.new()
            puts @gameBoard   
            turn_switcher(player1 ,player2)

            puts "#{player1.name} has won #{player1.wins} games"
            puts "#{player2.name} has won #{player2.wins} games"

            puts "\nType yes to start a new game or any key to exit\n"
            continue = gets.chomp.downcase
            if continue != "yes"
                quit()
            end
        end 
        return @gameBoard.board
    end

    def quit()
        puts "Thanks For Playing"
        exit(0)
    end

    def make_move(player, messgage = "")
        (messgage == "") ? (puts "#{player.name}(#{player.symbol}) Please Select a Column") : (puts messgage)
        move_input = (gets.chomp)

        if(['1','2','3','4','5','6','7']).include?(move_input) 
            if (@gameBoard.column_empty?(move_input.to_i))
                @gameBoard.drop_element(player.symbol,move_input.to_i)
                puts @gameBoard
            else
                make_move(player,"Sorry #{player.name} That Column is Full")
            end

        elsif(move_input.downcase == "save")
            saveGame()
            puts "game is saved"
            quit()
        elsif(move_input.downcase == "quit")
            quit()
        else
            make_move(player,"That is Not a Valid Column Entry")
        end    
    end

    def getPlayerNames()
        puts "Please enter a player name"
        name = (gets.chomp)
        return name
    end

    def turn_switcher(player1, player2)
        while (@gameBoard.check_for_full_board() == false)
            @current_turn = @player1
            make_move(player1)
            if(@gameBoard.check_win(player1))
                puts "#{@player1.name} wins!\n"
                @player1.award_win()
                break
            end
            @current_turn = @player2
            make_move (player2)
            if(@gameBoard.check_win( player2))
                player2.award_win()
                puts "#{player2.name} wins!\n"
                break
            end
        end

        if(@gameBoard.check_for_full_board())
            puts "Game Over: No one wins!\n"
        end
    end

    def saveGame()
        directory = "saves"

        if (!File.directory?(directory))
            Dir.mkdir(directory)
        end

        puts "Please enter a save file name"    
        filename = String.new
        while((filename.match(/^[a-zA-Z0-9]+$/) == nil) )           
            filename = gets.chomp.downcase
            if(File.exist?("../connect_four/saves/#{filename}.json"))
                puts "That filename already exists please choose another"
                filename = "-----"
            end
            if(filename.match(/^[a-zA-Z0-9]+$/) == nil)
                puts "Invalid Input\nPlease Enter a valid Filename"
            end
        end
        File.write("../connect_four/saves/#{filename}.json", self.to_json)    
    end
end

