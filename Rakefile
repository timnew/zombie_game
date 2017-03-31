require 'yaml'

class Player
  attr_reader :name, :score, :race

  def zomebie?
    race == :zombie
  end

  def human?
    race == :human
  end
end

class Game
  attr_reader :players

  def zombies
    players.select(&:zombie?)
  end

  def humans
    players.select(&:human?)
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
    players.each do |p|
      f.puts "HUMAN #{p}"
    end

    f.puts

    zombies.each do |p|
      f.puts "ZOMBIE #{p}"
    end
  end

  sh "cat #{args[:game_file]}"
end

task :run do

end
