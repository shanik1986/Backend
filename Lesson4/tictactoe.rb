require 'pry'

WINNING_LINES = [
  [1, 2, 3], [4, 5, 6], [7, 8, 9], # rows
  [2, 5, 8], [1, 4, 7], [3, 6, 9], # columns
  [1, 5, 9], [3, 5, 7]             # diagonals
]
WINNING_SCORE = 2
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

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
    prompt "Choose a square (#{joinor(empty_squares(brd))})"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)

    prompt "Sorry, that's not a valid choice"
  end

  brd[square] = PLAYER_MARKER
end

def computer_places_piece(brd, threat_details)
  if threat_details[:is_there_threat]
    play_defense(brd, threat_details)
  else
    play_random(brd)
  end
end

def play_random(brd)
  square = empty_squares(brd).sample
  brd[square] = COMPUTER_MARKER
end

def play_defense(brd, threat_details)
  square = threat_details[:location]
  brd[square] = COMPUTER_MARKER
end

def determine_threat(brd)
  threat_details = { is_there_threat: false }
  WINNING_LINES.each do |line|
    computer_marker_exists = brd.values_at(*line).include?(COMPUTER_MARKER)
    two_player_markers = brd.values_at(*line).count(PLAYER_MARKER) == 2

    if two_player_markers && !computer_marker_exists
      possible_threats = brd.select { |k, _| line.include?(k) }
      threat_details[:location] = possible_threats.key(INITIAL_MARKER)
      threat_details[:is_there_threat] = true
      return threat_details
    end
  end
  threat_details
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

loop do
  scores = { 'Player' => 0, 'Computer' => 0 }

  while scores.values.max < WINNING_SCORE
    board = initialize_board

    loop do
      display_board(board, scores)

      player_places_piece!(board)

      break if someone_won?(board) || board_full?(board)

      threat_details = determine_threat(board)

      computer_places_piece(board, threat_details)

      break if someone_won?(board) || board_full?(board)
    end

    display_board(board, scores)

    scores[detect_winner(board)] += 1 if someone_won?(board)
  end

  if someone_won?(board)
    prompt "#{detect_winner(board)} won!"
  else
    prompt "It's a tie!"
  end

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
