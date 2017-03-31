class Player
  class PermanentInfected < Zombie
    def initialize
      @new = true
    end

    def new?
      @new
    end

    def status
      :permanent_infected
    end

    def player=(player)
      player.reset_scores
      @player = player
    end

    def next_turn
      @new = false
    end
  end
end
