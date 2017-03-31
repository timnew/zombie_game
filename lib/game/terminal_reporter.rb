class Game
  class TerminalReporter
    extend Forwardable

    attr_reader :game
    delegate [:players, :humans, :zombies, :top_humans, :top_zombies, :finished?, :winner_force, :errors] => :game

    def initialize(game)
      @game = game
    end

    def report(title = nil)
      puts caption("===========================================================\n")
      puts caption(title)
      puts caption('-' * title.length + "\n")

      print_player_list
      print_player_division

      print_top_humans
      print_top_zombies

      print_result if finished?

      print_error unless errors.empty?
      puts caption("===========================================================\n")
    end

    def print_player_list
      puts caption('Players: ')
      players.each do |p|
        puts "  #{p.display_name}: #{p.role.display_name} #{p.display_score}"
      end
    end

    def print_player_division
      puts "\n#{zombie('Zombies')}: #{count(zombies.count)}  #{human('Humans')}: #{count(humans.count)}\n\n"
    end

    def print_top_humans
      puts caption('Top 5 humans: ')
      top_humans.take(5).each do |p|
        puts "  #{p.display_name}: #{p.display_score} handshakes"
      end
      puts "\n"
    end

    def print_top_zombies
      puts caption('Top 5 Zombies: ')
      top_zombies.take(5).each do |p|
        puts "  #{p.display_name}: #{p.display_score} infections"
      end
      puts "\n"
    end

    def print_result
      case winner_force
      when :human
        humans.each do |p|
          puts "#{p.display_name} won as #{human} with #{p.display_score} handshakes"
        end
      when :zombie
        zombies.each do |p|
          puts "#{p.display_name} won as #{zombie} by infected #{p.display_score} players"
        end
      end
    end

    def print_error
      puts "\n"

      errors.each do |err|
        err_message = err.respond_to?(:display_message) ? err.display_message : err.message

        puts "[#{Rainbow('Error').bright.red}] #{err_message}"
      end
    end

    protected

    def caption(text)
      Rainbow(text).bright.white
    end

    def count(count)
      Rainbow(count).bright.white
    end

    def zombie(name = 'Zombie')
      Rainbow(name).bright.red
    end

    def human(name = 'Human')
      Rainbow(name).bright.green
    end
  end
end

class Game
  class DSLError < RuntimeError
    def display_message
      "#{message}: [#{Rainbow(line_no).blue}] #{Rainbow(line).cyan}"
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
