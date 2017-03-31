class Game
  extend Forwardable

  autoload(:DSL, 'game/dsl')
  autoload(:DSLError, 'game/dsl_error')
  autoload(:TerminalReporter, 'game/terminal_reporter')

  attr_reader :turn_index, :errors

  attr_reader :dsl, :reporter
  delegate [:initial_report, :turn_report, :final_report, :append_error] => :reporter

  def initialize(reporter)
    @turn_index = 0
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

  def add_player(name, role)
    @players[name.downcase] = Player.new(name, role.new)
  end

  def zombies
    players.select(&:zombie_like?)
  end

  def humans
    players.select(&:human_like?)
  end

  def top_humans
    humans.sort_by(&:scores).reverse
  end

  def top_zombies
    zombies.sort_by(&:scores).reverse
  end

  def finished?
    humans.one? || humans.empty?
  end

  def winner_force
    humans.empty? ? :zombie : :human
  end

  def next_turn
    players.each(&:next_turn)
    turn_report(turn_index)

    @turn_index += 1
  end
end
