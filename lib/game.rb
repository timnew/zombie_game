class Game
  extend Forwardable

  autoload(:DSL, 'game/dsl')
  autoload(:DSLError, 'game/dsl_error')
  autoload(:TerminalReporter, 'game/terminal_reporter')
  autoload(:InvalidInteractionError, 'game/invalid_interaction_error')

  attr_reader :turn_index, :interation_limit, :antidote_limit, :errors

  attr_reader :dsl, :reporter
  delegate [:report, :append_error] => :reporter

  def initialize(reporter)
    @turn_index = 0
    @errors = []
    @players = {}

    @dsl = DSL.new(self)
    @reporter = reporter.new(self)
  end

  def start(interation_limit, antidote_limit)
    @interation_limit = interation_limit
    @antidote_limit = antidote_limit

    players.each(&:reset_interact_limit)

    reporter.initial_report
  end

  def players
    @players.values
  end

  def get_player(name)
    @players[name.downcase]
  end

  def add_player(name, role)
    @players[name.downcase] = Player.new(self, name, role.new)
  end

  def humans
    players.select(&:human_like?)
  end


  def zombies
    players.select(&:zombie_like?)
  end

  def top_humans
    humans.sort_by(&:sorting_scores).reverse
  end

  def top_zombies
    zombies.sort_by(&:sorting_scores)
  end

  def new_permanent_infectes
    zombies.select(&:permanent_infected?).select{|p| p.role.new? }
  end

  def winner_force
    humans.empty? ? :zombie : :human
  end

  def next_turn
    players.each(&:next_turn)
    reporter.turn_report(turn_index)

    @turn_index += 1
  end
end
