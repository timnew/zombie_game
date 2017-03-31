class Player
  extend Forwardable

  autoload(:Human, 'player/human')
  autoload(:Zombie, 'player/zombie')
  autoload(:TemporaryInfected, 'player/temporary_infected')
  autoload(:PermanentInfected, 'player/permanent_infected')

  attr_reader :name, :antidotes, :role

  def initialize(name, role)
    @name = name
    @scores = 0
    @antidotes = 1

    update_role role
  end

  delegate [:zombie_like?, :human_like?, :next_turn, :status] => :role

  [:human, :zombie, :permanent_infected, :temporary_infected].each do |status_name|
    define_method(:"#{status_name}?") do
      status == status_name
    end
  end

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

  def scores
    @scores.abs
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
end
