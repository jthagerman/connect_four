class Player
    def initialize(name,symbol)
        @name = name
        @symbol = symbol
    end

    def to_s
        return "Player name is #{@name} and their symbol is #{symbol}"
    end
end