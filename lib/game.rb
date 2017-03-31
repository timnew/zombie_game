class Game
  attr_reader :dsl, :players

  def initialize
    @players = {}

    @dsl = DSL.new(self)
  end

  def get_player(name)
    players[name]
  end

  def add_player(name, race)
    players[name] = Player.new(name, race)
  end

  def zombies
    players.values.select(&:zombie?)
  end

  def humans
    players.values.select(&:human?)
  end

  def next_round
    players.values.each(&:next_round)
  end
end
