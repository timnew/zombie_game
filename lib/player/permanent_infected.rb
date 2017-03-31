class Player
  class PermanentInfected < Zombie
    def name
      'Permanent Infected'
    end

    def player=(player)
      player.reset_scores
      @player = player
    end
  end
end
