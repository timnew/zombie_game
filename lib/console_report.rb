class ConsoleReport
  extend Forwardable

  attr_reader :game
  delegate [:players, :humans, :zombies, :top_human_players, :finished?, :winner_force, :errors] => :game

  def initialize(game)
    @game = game
  end

  def report
    print_player_list
    print_player_division

    print_top_humans

    print_result if finished?

    print_error unless errors.empty?
  end

  def print_player_list
    puts Rainbow('Players: ').bright.white
    players.each do |p|
      puts "  #{Rainbow(p.name).yellow}: #{colorize_status(p.status)} #{p.score}"
    end
  end

  def print_player_division
    puts "\n#{Rainbow('Zombie').red}: #{Rainbow(zombies.count).bright.white}  #{Rainbow('Humans').green}: #{Rainbow(humans.count).bright.white}\n\n"
  end

  def print_top_humans
    puts Rainbow('Top 5 humans:').bright.white
    top_human_players.take(5).each do |p|
      puts "  #{Rainbow(p.name).yellow}: #{Rainbow(p.score).bright.white}"
    end
    puts "\n"
  end

  def print_result
    case winner_force
    when :human
      humans.each do |p|
        puts "#{Rainbow(p.name).bright.green} won with score #{Rainbow(p.score).bright.blue}"
      end
    when :zombie
      puts Rainbow('Zombies win').bright.red
    end
  end

  def print_error
    puts "\n"

    errors.each do |err|
      if err.respond_to? :print_console
        err.print_console
      else
        puts "[#{Rainbow('Error').bright.red}] #{err.message}"
      end
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
