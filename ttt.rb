require 'pry'

WINNING_MOVES = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,5,9], [1,5,9], [3,5,7]]

current_moves = {1=>nil, 2=>nil, 3=>nil, 4=>nil, 5=>nil, 6=>nil, 7=>nil, 8=>nil, 9=>nil }

def check_for_win (moves)
  player_moves = moves.select { |i,m| m == 'x' }.keys
  computer_moves = moves.select { |i,m| m == 'o' }.keys
  if WINNING_MOVES.include? player_moves 
    "You won!"
  elsif WINNING_MOVES.include? computer_moves
    "You lost!"
  end
  #return nothing by default
end

def tests
  #game in progress
  current_moves = {1=>nil, 2=>'o', 3=>nil, 4=>nil, 5=>'x', 6=>nil, 7=>nil, 8=>'o', 9=>'x' }
  puts check_for_win current_moves

  #computer WINNING_MOVES
  current_moves = {1=>'o', 2=>'o', 3=>'o', 4=>nil, 5=>nil, 6=>nil, 7=>nil, 8=>nil, 9=>nil }
  puts check_for_win current_moves

  #player WINNING_MOVES
  current_moves = {1=>'o', 2=>'x', 3=>'o', 4=>nil, 5=>'x', 6=>nil, 7=>nil, 8=>'x', 9=>nil }
  puts check_for_win current_moves
end

loop do
  #ask for position
  puts "Positions " + current_moves.select { |i,m| m != nil }.keys.to_s + " are already taken. Which position? (1-9, x for tests)"
  pos = gets.chomp

  case pos
  when 1..9
    #check if already taken
    if current_moves.fetch(pos.to_i) != nil
      puts "spot already taken"
    else
      current_moves.fetch(pos.to_i) = pos
    end
  when 'x'
    tests
end
end




