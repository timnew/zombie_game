class ConsoleReport
  extend Forwardable

  attr_reader :game
  delegate [:players, :humans, :zombies] => :game

  def initialize(game)
    @game = game
  end

  def report
    puts Rainbow('Players: ').bright.white
    players.values.each do |p|
      puts "  #{Rainbow(p.name.titleize).yellow}: #{colorize_status(p.status)} #{p.score}"
    end
    puts "\n#{Rainbow('Zombie').red}: #{Rainbow(zombies.count).bright.white}  #{Rainbow('Humans').green}: #{Rainbow(humans.count).bright.white}\n\n"

    puts Rainbow('Top 5 humans:').bright.white
    humans.sort_by(&:score).reverse.take(5).each do |p|
      puts "  #{Rainbow(p.name).yellow}: #{Rainbow(p.score).bright.white}"
    end
    puts "\n\n"

    if humans.empty?
      puts Rainbow('Zombies win').bright.red
    end

    if humans.one?
      winner = humans.first
      puts "#{Rainbow(winner.name).bright.green} won with score #{Rainbow(winner.score).bright.blue}"
    end
  end

  protected

  def colorize_status(player_status)
    case player_status
    when :human then Rainbow('Human').green.bright
    when :zombie then Rainbow('Zombie').red.bright
    when :temporary_infected then Rainbow('Infected').red
    when :permanent_infected then Rainbow('Infected').red.bright
    else Rainbow('Unknown').magenta
    end
  end
end
