class Game
  extend Forwardable

  autoload(:DSL, 'game/dsl')
  autoload(:DSLError, 'game/dsl_error')
  autoload(:TerminalReporter, 'game/terminal_reporter')

  attr_reader :round_index, :errors

  attr_reader :dsl, :reporter
  delegate [:report] => :reporter

  def initialize(reporter)
    @round_index = 0
    @errors = []
    @players = {}

    @dsl = DSL.new(self)
    @reporter = reporter.new(self)

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

  def top_humans
    humans.sort_by(&:score).reverse
  end

  def top_zombies
    zombies.sort_by(&:score).reverse
  end

  def finished?
    humans.one? || humans.empty?
  end

  def winner_force
    humans.empty? ? :zombie : :human
  end

  def next_round
    players.each(&:next_round)
    report("Round #{round_index} Report")

    @round_index += 1
  end

  def error(err)
    errors << err
  end
end
