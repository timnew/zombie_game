class Player
  extend Forwardable

  autoload(:Human, 'player/human')
  autoload(:Zombie, 'player/zombie')
  autoload(:TemporaryInfected, 'player/temporary_infected')
  autoload(:PermanentInfected, 'player/permanent_infected')

  attr_reader :game, :name, :antidotes, :role, :interact_limit, :contact_list

  def initialize(game, name, role)
    @game = game
    @name = name
    @scores = 0
    @antidotes = 1
    @contact_list = Set.new
    reset_interact_limit

    update_role role
  end

  delegate [:zombie_like?, :human_like?, :status] => :role

  [:human, :zombie, :permanent_infected, :temporary_infected].each do |status_name|
    define_method(:"#{status_name}?") do
      status == status_name
    end
  end

  def interact(another_player)
    if contactable?(another_player.name) && another_player.contactable?(name)
      role.touch(another_player)
      another_player.role.touch(self)
      reset_interact_limit
    else
      raise Game::InvalidInteractionError.new(self, another_player)
    end
  end

  def contactable?(name)
    contact_list.add?(name)
  end


  def apply_antidote
    return unless @antidotes > 0

    @antidotes -= 1

    role.antidote_applied
  end

  def update_role(role)
    role.player = self
    @role = role
  end

  def scores
    @scores.abs
  end

  def handshakes
    @scores >= 0 ? @scores : 0
  end

  def infections
    @scores <= 0 ? -@scores : 0
  end

  def sorting_scores
    @scores
  end

  def update_scores(amount)
    @scores += amount
  end

  def reset_scores
    @scores = 0
  end

  def reset_interact_limit
    @interact_limit = game.interation_limit
  end

  def next_turn
    @interact_limit -= 1

    if @interact_limit.zero?
      update_role PermanentInfected.new
      true
    else
      role.next_turn
    end
  end
end
