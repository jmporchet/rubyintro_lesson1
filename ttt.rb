require 'pry'

WINNING_MOVES = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]

current_moves = {1=>" ", 2=>" ", 3=>" ", 4=>" ", 5=>" ", 6=>" ", 7=>" ", 8=>" ", 9=>" " }

def check_for_win (moves)
  player_moves = moves.select { |i,m| m == 'x' }.keys
  computer_moves = moves.select { |i,m| m == 'o' }.keys

  WINNING_MOVES.each do |line|
    return "You won!" if moves.values_at(*line).count('x') == 3 
    return "You lost!" if moves.values_at(*line).count('o') == 3 
  end
  nil
end

def draw_grid(current_moves)
  system ("cls")

  3.times do |line|
      puts "     |     |     "
      puts "  #{current_moves.fetch(line*3+1)}  |  #{current_moves.fetch(line*3+2)}  |  #{current_moves.fetch(line*3+3)}  "
      puts "_____|_____|_____"
  end
end

loop do
  #ask for position
  puts "Positions " + current_moves.select { |index,move| move != " " }.keys.to_s + " are already taken. Which position? (1-9, 0 for tests)"
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