WIN_COMBINATIONS = [
  [0,1,2], #Top row
  [3,4,5], #Middle row
  [6,7,8], #Bottom row
  [0,4,8], #Left to Right diagonals
  [2,4,6], #Right to Left diagonals
  [0,3,6], #First columns
  [1,4,7], #Second columns
  [2,5,8] #Third columns
]

def display_board(board)
  puts" #{board[0]} | #{board[1]} | #{board[2]} "
  puts"-----------"
  puts" #{board[3]} | #{board[4]} | #{board[5]} "
  puts"-----------"
  puts" #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
   count = 0
   board.each do |unit|
     if unit == "X" || unit == "O"
       count += 1
     end
   end
   return count
 end

 def current_player(board)
   current_player = "X"
   if turn_count(board) % 2 != 0
     current_player = "O"
   end
   return current_player
 end

 def won?(board)
   WIN_COMBINATIONS.find do |win_index|
      (board[win_index[0]] == "X" && board[win_index[1]] == "X" && board[win_index[2]] == "X") || (board[win_index[0]] == "O" && board[win_index[1]] == "O" && board[win_index[2]] == "O")
    end
  end

  def full?(board)
     board.all?  { |position| (position == "X" || position == "O") }
   end

  def draw?(board)
    if !won?(board) && full?(board)
      return true
    else
      return false
    end
  end

   def over?(board)
     if won?(board) || full?(board) || draw?(board)
       return true
     else
       return false
     end
   end

   def winner(board)
     win = won?(board)
     if win
       return board[win[0]]
     end
   end

   def play(board)
      while !over?(board)
        turn(board)
      end
      if won?(board)
        puts "Congratulations #{winner(board)}!"
      elsif draw?(board)
        puts "Cats Game!"
      end
    end
