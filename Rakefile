require 'yaml'
require './lib/zombie_game'

desc 'Generate new config'
task :new_config, [:config_file] do |t, args|
  args.with_defaults(config_file: 'config.yml')

  File.open(args[:config_file], 'w') do |f|
    yaml = YAML.dump(
      players: %w(Tim David Jason Kiril),
      zombie_count: 1,
      interation_turn_limit: 6,
      antidote_turn_limit: 3
    )
    f.puts(yaml)
  end

  puts "Configraution file #{args[:config_file]} has been generated"
end

desc 'Create the script for a new game'
task :new_game, [:script_file, :config_file] do |t, args|
  args.with_defaults(script_file: 'game.txt', config_file: 'config.yml')

  config = YAML.load_file args[:config_file]

  players = config[:players]
  zombies = []

  config[:zombie_count].times do
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

    f.puts "GAME_START #{config[:interation_turn_limit]} #{config[:antidote_turn_limit]}"
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
