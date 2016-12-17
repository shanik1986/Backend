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

def find_square(brd, marker)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(marker) == 2
      square = brd.select { |k, v| line.include?(k) && v == INITIAL_MARKER }
      square = square.keys.first
      return square if !!square
    end
  end
end

def determine_strategy!(brd, strategy)
  strategy[:square] = find_square(brd, COMPUTER_MARKER)
  if !strategy[:square].nil?
    strategy[:should_attack] = true
    return
  end

  strategy[:square] = find_square(brd, PLAYER_MARKER)
  if !strategy[:square].nil?
    strategy[:should_defend] = true
    return
  end

  strategy[:square] = empty_squares(brd).sample
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
      strategy = { should_attack: false, should_defend: false, square: nil }

      display_board(board, scores)

      player_places_piece!(board)

      break if someone_won?(board) || board_full?(board)

      determine_strategy!(board, strategy)

      board[strategy[:square]] = COMPUTER_MARKER

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
