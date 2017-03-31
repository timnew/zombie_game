class Game
  autoload(:DSL, 'game/dsl')
  autoload(:DSLError, 'game/dsl_error')
  autoload(:ConsoleReport, 'game/console_report')

  attr_reader :dsl, :errors

  def initialize
    @errors = []
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
    players.select(&:zombie_like?)
  end

  def humans
    players.select(&:human_like?)
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

  def error(err)
    errors << err
  end

  def next_round
    players.each(&:next_round)
  end
end
