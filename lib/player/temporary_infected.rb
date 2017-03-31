class Player
  class TemporaryInfected < Zombie
    attr_accessor :infectness

    def initialize
      @infectness = 0
    end

    def name
      'Temporary Infected'
    end

    def apply_antidote
      player.update_role Human.new
    end

    def next_round
      @infectness += 1
      player.update_role PermanentInfected.new if @infectness > 3
    end
  end
end
