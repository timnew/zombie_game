class Player
  extend Forwardable

  autoload(:Human, 'player/human')
  autoload(:Zombie, 'player/zombie')
  autoload(:TemporaryInfected, 'player/temporary_infected')
  autoload(:PermanentInfected, 'player/permanent_infected')

  attr_reader :name, :scores, :antidotes, :role

  def initialize(name, role)
    @name = name
    @scores = 0
    @antidotes = 1

    update_role role
  end

  delegate [:zombie_like?, :human_like?, :next_turn] => :role

  def interact(another_player)
    role.touch(another_player)
    another_player.role.touch(self)
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

  def update_score(amount)
    @scores += amount
  end

  def reset_score
    @scores = 0
  end
end
