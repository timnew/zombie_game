class Player
  attr_reader :name, :score, :race, :antidote_count

  def initialize(name, race)
    @name = name
    @race = race
    @score = 0
    @antidote_count = 1
    @infectness = nil
  end

  def status
    if race == :zombie
      :zombie
    elsif @infectness.nil?
      :human
    elsif @infectness > 3
      :permanent_infected
    else
      :temporary_infected
    end
  end

  def zombie?
    status != :human
  end

  def human?
    status == :human
  end

  def infected?
    status == :permanent_infected || status == :temporary_infected
  end

  def antidote?
    antidote_count > 0
  end

  def touch(another_player)
    interact(another_player)
    another_player.interact(self)
  end

  def antidote
    return unless antidote?
    @antidote_count -= 1

    @infectness = nil if infected? && @infectness < 3
  end

  def next_round
    @infectness += 1 if infected?
  end

  protected

  def interact(another_player)
    if zombie?
      another_player.infect
    else
      another_player.handshake
    end
  end

  def infect
    @infectness = 0 unless infected?
  end

  def handshake
    @score += 1 if human?
  end
end
