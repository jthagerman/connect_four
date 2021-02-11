require_relative 'player'
class Controller

    def initalize()
        player1 = Player.new(getPlayerNames,"⚫")
        player2 = Player.new(getPlayerNames,"⚪")


    end 
    def getPlayerNames()
        name = ""
        return name
    end
end