if ARGV.length != 2
  puts 'Please provide the names of the two players as arguments.'
  exit
end

$LOAD_PATH << '.'

require 'game'
Fanorona::Game.new(*ARGV).startGame