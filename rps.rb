require 'pry'

  CHOICES = {'p'=>'Paper', "r"=>'Rock', "s"=>'Scissors'}

def wins(my_move, computer_move)
  win_cases = [['p','r'], ['r','s'], ['s','p']]
  puts "moves: " + my_move + " " + computer_move

  current_game = [my_move, computer_move]

  puts "You chose #{CHOICES[my_move]} and the computer chose #{CHOICES[computer_move]}"

  if my_move == computer_move
    "Draw"
  elsif win_cases.include?(current_game)
    "You won!"
  else
    "You lost..."
  end
end

def main
  puts "Choose one: (P/R/S)"

  input = gets.chomp.downcase

  moves = ['p','r','s']
  computer = Random.new()
  computer = computer.rand(1..3).to_i-1

  computer_move = moves[computer]

  puts wins(input, computer_move)

  puts "Play again?"
end

puts "Play Paper Rock Scissors!"
main
while gets.chomp.downcase == "y"
  main
end
