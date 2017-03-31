class Game
  class DSL
    def self.run_script(game, script)
      dsl = new(game)

      script.each do |line|
        args = line.split(' ').compact

        next if args.empty?

        cmd = args.shift.downcase
        next if cmd.start_with?('#')

        begin
          dsl.public_send(cmd, *args)
        rescue NoMethodError, ArgumentError
          puts "[#{Rainbow('ERROR').red}] Invalid instruction: #{Rainbow(line).cyan}\n"
        end
      end
    end

    def human(name)
      game.add_player(name, :human)
    end

    def zombie(name)
      game.add_player(name, :zombie)
    end

    def interact(player1, player2)
      game.get_player(player1).interact(@game.get_player(player2))
    end
    alias i interact

    alias touch interact # Backward Compactibility
    alias t touch

    def antidote(player)
      game.get_player(player).apply_antidote
    end
    alias a antidote

    def next_round
      game.next_round
    end
    alias nr next_round

    def report
      game.report
    end

    protected

    def initialize(game)
      @game = game
    end

    attr_reader :game
  end
end
