class Player
    attr_accessor :name, :symbol

    def initialize(name,symbol)
        @name = name
        @symbol = symbol
    end

    def to_s
        return @symbol
    end
end