class Game
  class TerminalReporter
    extend Forwardable

    attr_reader :game, :errors
    delegate [:players, :humans, :zombies, :top_humans, :top_zombies, :new_permanent_infectes, :winner_force] => :game

    def initialize(game)
      @errors = []
      @game = game
    end

    def error?
      errors.any?{ |e| e.instance_of?(DSLError) }
    end

    def initial_report
      return if error?

      print_title('Game Started')

      print_player_list
      print_player_division
    end

    def turn_report(turn_index)
      return if error?
      print_hr
      puts

      print_title("Turn #{turn_index}")

      print_player_list
      print_player_division

      print_top_humans
      print_top_zombies
      print_new_permanent_infectes
    end

    def report
      return error_report if error?
      print_hr
      puts

      print_title('Game Status Report')

      print_player_list
      print_player_division

      print_top_humans
      print_top_zombies
    end

    def error_report
      print_hr
      print_title('Game Error')

      print_error
    end

    def append_error(error)
      errors << error
    end

    protected

    def print_hr
      puts "#{caption('=' * 20)}\n"
    end

    def print_title(text)
      puts "--#{'-' * text.length}--\n  #{caption(text)}  \n--#{'-' * text.length}--\n"
    end

    def print_player_list
      puts caption('Players: ')
      players.each do |p|
        puts "  #{p.display_name}: #{p.role.display_name}  A: #{p.display_antidotes}  S: #{p.display_scores}  I: #{p.display_interact_limit}"
      end
    end

    def print_player_division
      puts "\n#{zombie('Zombies')}: #{count(zombies.count)}  #{human('Humans')}: #{count(humans.count)}\n\n"
    end

    def print_top_humans
      puts caption('Top 5 humans: ')
      top_humans.take(5).each do |p|
        puts "  #{p.display_name}: #{p.display_handshakes} handshakes"
      end
      puts "\n"
    end

    def print_top_zombies
      puts caption('Top 5 Zombies: ')
      top_zombies.take(5).each do |p|
        puts "  #{p.display_name}: #{p.display_infections} infections"
      end
      puts "\n"
    end

    def print_new_permanent_infectes
      return if new_permanent_infectes.empty?
      puts caption('New permanent infected:')
      new_permanent_infectes.each do |p|
        puts "  #{p.display_name} is just #{zombie('permanent infected')}"
      end
    end

    def print_result
      case winner_force
      when :human
        humans.each do |p|
          puts "#{p.display_name} won as #{human} with #{p.display_handshakes} handshakes"
        end
      when :zombie
        zombies.each do |p|
          puts "#{p.display_name} won as #{zombie} by infected #{p.display_infections} players"
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

  class InvalidInteractionError < RuntimeError
    def display_message
      "#{message}: [#{Rainbow(line_no).blue}] #{player_names.map{|n| Rainbow(n).cyan}.join(', ')}"
    end
  end
end

class Player
  def display_name
    Rainbow(name).yellow
  end

  def display_scores
    Rainbow(scores).bright.white
  end

  def display_handshakes
    Rainbow(handshakes).green
  end

  def display_infections
    Rainbow(infections).red
  end

  def display_antidotes
    Rainbow(antidotes).bright.blue
  end

  def display_interact_limit
    Rainbow(interact_limit).cyan
  end

  class Human
    def display_name
      Rainbow('Human').green.bright
    end
  end

  class Zombie
    def display_name
    Rainbow('Zombie').red.bright
    end
  end
  class TemporaryInfected
    def display_name
      Rainbow('Temporary Infected').red
    end
  end
  class PermanentInfected
    def display_name
      Rainbow('Permanent Infected').red.bright
    end
  end
end
