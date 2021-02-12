#/lib/player
require 'json'
class Player
    attr_accessor :name, :symbol, :wins

    def initialize(name,symbol,wins=0)
        @name = name
        @symbol = symbol
        if(wins == 0)
            @wins = 0
        else
            @wins = wins
        end
    end

    def to_json
        JSON.dump ({
          :name => @name,
          :symbol => @symbol,
          :wins => @wins
        })
    end

    def self.from_json(string)
        data = JSON.load string
        self.new(data['name'], data['symbol'], data['wins'])
    end

    def award_win()
        @wins += 1
    end
    
    def to_s
        return @symbol
    end
end