class Game
  attr_reader :dsl

  def initialize
    @players = {}

    @dsl = DSL.new(self)
  end

  def players
    @players.values
  end

  def get_player(name)
    @players[name.downcase]
  end

  def add_player(name, race)
    @players[name.downcase] = Player.new(name, race)
  end

  def zombies
    players.select(&:zombie?)
  end

  def humans
    players.select(&:human?)
  end

  def top_human_players
    humans.sort_by(&:score).reverse
  end

  def finished?
    humans.one? || humans.empty?
  end

  def winner_force
    humans.empty? ? :zombie : :human
  end

  def next_round
    players.each(&:next_round)
  end
end
