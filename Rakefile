require 'yaml'
require './lib/zombie_game'

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

  game = Game.new
  dsl = game.dsl
  dsl.run_script_file(args[:game_file])
  dsl.report
end

task :default => [:run]
