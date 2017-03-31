module PlayerFactory
  def human
    Player.new('human', Player::Human.new).tap{|p| yield(p) if block_given? }
  end

  def zombie
    Player.new('zombie', Player::Zombie.new).tap{|p| yield(p) if block_given? }
  end

  def temp_infected
    Player.new('human', Player::TemporaryInfected.new).tap{|p| yield(p) if block_given? }
  end

  def perm_infected
    Player.new('zombie', Player::PermanentInfected.new).tap{|p| yield(p) if block_given? }
  end
end
