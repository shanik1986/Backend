WINNING_LINES = [
  [1, 2, 3], [4, 5, 6], [7, 8, 9], # rows
  [2, 5, 8], [1, 4, 7], [3, 6, 9], # columns
  [1, 5, 9], [3, 5, 7]             # diagonals
]
WIN_SCORE = 2
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
BEGINNING_SETTING = 'choose'

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/AbcSize
def display_board(brd, scores)
  system 'cls'
  puts "You're a #{PLAYER_MARKER}. Computer is a #{COMPUTER_MARKER}"
  puts "Player: #{scores['Player']};\t\tComputer: #{scores['Computer']}"
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
end
# rubocop:enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def joinor(array, delimeter = ',', last_item_connection = 'or')
  if array.size > 1
    series = array[0..(array.size - 2)].join(delimeter)
    series += " #{last_item_connection} #{array.last}"
  else
    series = array[0]
  end
  series
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Your turn. Choose a square (#{joinor(empty_squares(brd))})"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)

    prompt "Sorry, that's not a valid choice"
  end

  brd[square] = PLAYER_MARKER
end

def find_square(brd, marker)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(marker) == 2
      square = brd.select { |k, v| line.include?(k) && v == INITIAL_MARKER }
      square = square.keys.first
      return square if square
    end
  end
  nil
end

def determine_strategy(brd)
  square = find_square(brd, COMPUTER_MARKER) # Winning attack strategy
  return square unless !square

  square = find_square(brd, PLAYER_MARKER)   # Urgent defence strategy
  return square unless !square

  return 5 if brd[5] == INITIAL_MARKER       # Focus on center strategy

  empty_squares(brd).sample                  # Random pick strategy
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def play_round(brd, is_player_turn)
  if is_player_turn
    player_places_piece!(brd)
  else
    square = determine_strategy(brd)
    brd[square] = COMPUTER_MARKER
  end
end

def player_chooses_beginner
  answer = ''
  prompt "Who would you like to go first this round? (player or computer)"
  loop do
    answer = gets.chomp.downcase
    break if %w(player computer).include?(answer)
    prompt "Invalid input! Please answer with 'Player' or 'Computer' only!"
  end
  answer
end

def decide_turn
  answer = player_chooses_beginner if BEGINNING_SETTING == 'choose'

  if BEGINNING_SETTING == 'player' || answer == 'player'
    is_player_turn = true
  elsif BEGINNING_SETTING == 'computer' || answer == 'computer'
    is_player_turn = false
  end

  is_player_turn
end

def display_win_status(brd, game_type)
  if someone_won?(brd)
    prompt "#{detect_winner(brd)} won the #{game_type}!"
  else
    prompt "The #{game_type} is a tie!"
  end
  if game_type == 'mini game'
    prompt "Enter any key to continue"
    gets.chomp
  end
end

loop do
  scores = { 'Player' => 0, 'Computer' => 0 }

  while scores.values.max < WIN_SCORE
    board = initialize_board
    is_player_turn = decide_turn

    loop do
      display_board(board, scores)

      play_round(board, is_player_turn)

      if someone_won?(board) || board_full?(board)
        scores[detect_winner(board)] += 1 if someone_won?(board)
        display_board(board, scores)
        display_win_status(board, 'mini game') if scores.values.max < WIN_SCORE
        break
      end

      is_player_turn = !is_player_turn
    end
  end

  display_win_status(board, 'whole game')
  prompt "Play again? (y or n)"
  answer = ''
  loop do
    answer = gets.chomp
    break if %w(y n yes no).include?(answer.downcase)
    prompt "Please answer only with a 'yes'(y) or a 'no'(n)"
  end

  break unless %w(y yes).include?(answer.downcase)
end

prompt 'Thanks for playing! Bye...'
