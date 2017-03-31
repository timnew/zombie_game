
class Game
  def self.run(file)
    Game.new do |g|
      File.open(file, 'r') do |f|
        f.each_line do |line|
          args = line.split(' ').compact

          next if args.empty?

          cmd = args.shift.downcase
          next if cmd.start_with?('#')

          g.send(cmd, *args)
        end
      end
    end
  end

  attr_reader :players

  def initialize
    @players = {}

    yield self if block_given?
  end

  def zombies
    players.values.select(&:zombie?)
  end

  def humans
    players.values.select(&:human?)
  end

  def human(name)
    players[name] = Player.new(name, :human)
  end

  def zombie(name)
    players[name] = Player.new(name, :zombie)
  end

  def touch(from, to)
    players[from].touch(players[to])
  end
  alias t touch

  def antidote(player)
    players[player].antidote
  end
  alias a antidote

  def next_round
    players.values.each(&:next_round)
  end
  alias nr next_round

  def report
    puts 'Players: '
    players.values.each do |p|
      puts "  #{p.name}: #{p.status}"
    end

    puts "Zombie: #{zombies.count} Humans: #{humans.count}\n\n"
    puts 'Top 5 humans:'
    humans.sort_by(&:score).reverse.take(5).each do |p|
      puts "  #{p.name}: #{p.score}"
    end

    if humans.empty?
      puts 'Zombies win'
    end

    if humans.one?
      winner = humans.first
      puts "#{winner.name} won with score #{winner.score}"
    end
  end
end
