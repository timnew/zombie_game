class Game
  class TerminalReporter
    extend Forwardable

    attr_reader :game, :errors
    delegate [:players, :humans, :zombies, :top_humans, :top_zombies, :finished?, :winner_force] => :game

    def initialize(game)
      @errors = []
      @game = game
    end

    def error?
      !errors.empty?
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
    end

    def final_report
      return error_report if error?
      return unless game.finished?

      print_hr
      puts

      print_title('Game finished')

      print_player_list
      print_player_division

      print_top_humans
      print_top_zombies

      print_hr
      puts

      print_result
      puts
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

      return unless game.finished?

      print_hr
      puts

      print_result
      puts
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
        puts "  #{p.display_name}: #{p.role.display_name} A:#{p.display_antidotes} S:#{p.display_scores}"
      end
    end

    def print_player_division
      puts "\n#{zombie('Zombies')}: #{count(zombies.count)}  #{human('Humans')}: #{count(humans.count)}\n\n"
    end

    def print_top_humans
      puts caption('Top 5 humans: ')
      top_humans.take(5).each do |p|
        puts "  #{p.display_name}: #{p.display_scores} handshakes"
      end
      puts "\n"
    end

    def print_top_zombies
      puts caption('Top 5 Zombies: ')
      top_zombies.take(5).each do |p|
        puts "  #{p.display_name}: #{p.display_scores} infections"
      end
      puts "\n"
    end

    def print_result
      case winner_force
      when :human
        humans.each do |p|
          puts "#{p.display_name} won as #{human} with #{p.display_scores} handshakes"
        end
      when :zombie
        zombies.each do |p|
          puts "#{p.display_name} won as #{zombie} by infected #{p.display_scores} players"
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
end

class Player
  def display_name
    Rainbow(name).yellow
  end

  def display_scores
    Rainbow(scores).bright.white
  end

  def display_antidotes
    Rainbow(antidotes).bright.blue
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
