class Game
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
        puts "  #{p.display_name}: #{p.role.display_name} #{p.display_score}"
      end
    end

    def print_player_division
      puts "\n#{Rainbow('Zombie').red}: #{Rainbow(zombies.count).bright.white}  #{Rainbow('Humans').green}: #{Rainbow(humans.count).bright.white}\n\n"
    end

    def print_top_humans
      puts Rainbow('Top 5 humans:').bright.white
      top_human_players.take(5).each do |p|
        puts "  #{p.display_name}: #{p.display_score}"
      end
      puts "\n"
    end

    def print_result
      case winner_force
      when :human
        humans.each do |p|
          puts "#{p.display_name} won as #{Rainbow('Human').green} with score #{p.display_score}"
        end
      when :zombie
        zombies.each do |p|
          puts "#{p.display_name} won as #{Rainbow('Zombie').red}"
        end
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
  end
end

class Player
  def display_name
    Rainbow(name).yellow
  end

  def display_score
    Rainbow(score).bright.white
  end

  class Human
    def display_name
      Rainbow(name).green.bright
    end
  end

  class Zombie
    def display_name
    Rainbow(name).red.bright
    end
  end
  class TemporaryInfected
    def display_name
      Rainbow(name).red
    end
  end
  class PermanentInfected
    def display_name
      Rainbow(name).red.bright
    end
  end
end
