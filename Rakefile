require 'yaml'

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

task :new_game, [:game_file, :player_config] do |t, args|
  args.with_defaults(game_file: 'game.txt', player_config: 'players.yml')

  config = YAML.load_file args[:player_config]

  players = config['players']
  zombies = []

  config['zombie_count'].times do
    zombies << players.delete_at(rand(players.size))
  end

  File.open(args[:game_file], 'w') do |f|
    f.puts '# Player List'
    players.each do |p|
      f.puts "HUMAN #{p}"
    end
    zombies.each do |p|
      f.puts "ZOMBIE #{p}"
    end

    f.puts <<-EOD

# TOUCH <player>
# t <player>

# ANTIDOTE <player>
# a <player>

# NEXT_ROUND
# nr
    EOD
  end

  sh "cat #{args[:game_file]}"
end

task :run, [:game_file] do |t, args|
  args.with_defaults(game_file: 'game.txt')

  Game.run(args[:game_file])
      .report
end

task :default => [:run]
