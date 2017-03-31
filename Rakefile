require 'yaml'
require './lib/zombie_game'

desc 'Create the script for a new game'
task :new_game, [:script_file, :config_file] do |t, args|
  args.with_defaults(script_file: 'game.txt', config_file: 'config.yml')

  config = YAML.load_file args[:config_file]

  players = config['players']
  zombies = []

  config['zombie_count'].times do
    zombies << players.delete_at(rand(players.size))
  end

  File.open(args[:script_file], 'w') do |f|
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

# NEXT_TURN
# nt

    EOD

    f.puts "GAME_START #{config['total_turns']}"
  end

  Rake::Task[:run].execute
end

desc 'Run the game'
task :run, [:script_file] do |t, args|
  sh 'clear'
  args.with_defaults(script_file: 'game.txt')

  game = Game.new(Game::TerminalReporter)
  game.dsl.run_script_file(args[:script_file])
  game.report
end

task :default => [:run]
