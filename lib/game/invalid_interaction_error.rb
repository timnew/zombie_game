class Game
  class InvalidInteractionError < RuntimeError
    attr_accessor :line_no
    attr_reader :players

    def initialize(*players)
      @players = players
    end

    def player_names
      players.map(&:name)
    end

    def message
      'Invalid interaction'
    end
  end
end
