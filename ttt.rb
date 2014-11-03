require 'pry'

WINNING_MOVES = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]

current_moves = {1=>" ", 2=>" ", 3=>" ", 4=>" ", 5=>" ", 6=>" ", 7=>" ", 8=>" ", 9=>" " }

def check_for_win (moves)
  player_moves = moves.select { |i,m| m == 'x' }.keys
  computer_moves = moves.select { |i,m| m == 'o' }.keys
  if WINNING_MOVES.include? player_moves 
    "You won!"
  elsif WINNING_MOVES.include? computer_moves
    "You lost!"
  end
  binding.pry
  #return nothing by default
end

def run_tests
  #game in progress
  current_moves = {1=>nil, 2=>'o', 3=>nil, 4=>nil, 5=>'x', 6=>nil, 7=>nil, 8=>'o', 9=>'x' }
  puts check_for_win current_moves

  #computer WINNING_MOVES
  current_moves = {1=>'o', 2=>'o', 3=>'o', 4=>nil, 5=>nil, 6=>nil, 7=>nil, 8=>nil, 9=>nil }
  puts check_for_win current_moves

  #player WINNING_MOVES
  current_moves = {1=>'x', 2=>'x', 3=>'x', 4=>nil, 5=>'o', 6=>nil, 7=>nil, 8=>'o', 9=>nil }
  puts check_for_win current_moves

  #player WINNING_MOVES
  current_moves = {1=>'x', 2=>'o', 3=>nil, 4=>'o', 5=>'x', 6=>nil, 7=>nil, 8=>nil, 9=>'x' }
  puts check_for_win current_moves
end

def draw_placeholder_cell (pos)
  pos.fetch(pos.to_i) == nil ? " " : current_moves.fetch(pos.to_i)
end

def draw_grid(current_moves)
  system ("cls")

  3.times do |line|
      puts "     |     |     "
      puts "  #{current_moves.fetch(line*3+1)}  |  #{current_moves.fetch(line*3+2)}  |  #{current_moves.fetch(line*3+3)}  "
      puts "_____|_____|_____"
  end

=begin
  puts "     |     |     "
  puts "  " + current_moves.fetch(1).to_s + "  |  " + current_moves.fetch(2).to_s + "  |  " + current_moves.fetch(3).to_s + "  "
  puts "     |     |     "
  puts "-----|-----|-----"
  puts "     |     |     "
  puts "  " + current_moves.fetch(4).to_s + "  |  " + current_moves.fetch(5).to_s + "  |  " + current_moves.fetch(6).to_s + "  "
  puts "     |     |     "
  puts "-----|-----|-----"
  puts "     |     |     "
  puts "  " + current_moves.fetch(7).to_s + "  |  " + current_moves.fetch(8).to_s + "  |  " + current_moves.fetch(9).to_s + "  "
  puts "     |     |     "
=end

end

loop do
  #ask for position
  puts "Positions " + current_moves.select { |index,move| move != nil }.keys.to_s + " are already taken. Which position? (1-9, 0 for tests)"
  pos = gets.chomp.to_i

  case pos
  when 1..9
    #check if already taken
    if current_moves.fetch(pos.to_i) != " "
      puts "spot already taken"
    else
      #update the player move
      current_moves.store(pos.to_i, 'x')
      #get the remaining free spots and add one random 'o' for the computer move
      available_moves = current_moves.select { |index,move| move == " " }
      computer_move = available_moves.keys.sample(1).first
      current_moves.store(computer_move, 'o')
      draw_grid(current_moves)
      if check_for_win(current_moves) != nil
        puts check_for_win(current_moves)
        exit
      end
    end
  when 0
    run_tests
  end
end




