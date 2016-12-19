require 'pry'
# 1. Initialize deck
# 2. Deal cards for the dealer and player
# 3. Player decides 'hit' or 'stay'
#   - repeat until  'bust' or 'stay'
# 4. If player busts, dealer wins - Go to 1
# 5. Dealer draws until sum > 16 or 'bust'
# 6. If dealer busts, player wins - Go to 1
# 7. Compare both sums and declare winner

VALUES = {
  '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8,
  '9' => 9, '10' => 10, 'Jack' => 10, 'Queen' => 10, 'King' => 10, 'Ace' => 11
}
SUITS = {'H' => 'Hearts', 'C' => 'Clubs', 'D' => 'Diamonds', 'S' => 'Spades'}
MAX_SUM = 21

def prompt(msg)
  puts "=> #{msg}"
end

def initialize_deck()
  deck = []
  VALUES.each_key do |card|
    SUITS.each_key do |suit|
      deck << [card, suit]
    end
  end
  deck
end

def initial_deal!(deck, current_status)
  hit!(2, deck, current_status, :dealer_cards)
  hit!(2, deck, current_status, :player_cards)
  prompt "Dealer has: #{current_status[:dealer_cards].first.first} " +
    "and an unknown card"
  display_cards('Player', current_status[:is_player_round])
end

def get_all_firsts(nested_array)
  firsts = []
  nested_array.each {|item| firsts << item.first }
  firsts
end

def display_cards(first, *second cards, is_player_round)
  case
  when first && second
  when first

  end
  prompt "#{identity} has: #{join_and(get_all_firsts(cards))}"
end

def join_and(array, delimeter = ',', last_item_connection = 'and')
  if array.size > 1
    series = array[0..(array.size - 2)].join(delimeter)
    series += " #{last_item_connection} #{array.last}"
  else
    series = array[0]
  end
  series
end

def hit!(number = 1, deck, current_status, card_receiver)
  number.times {current_status[card_receiver] << deck.delete(deck.sample)}
end

def player_round(deck, current_status)
  sum = 0

  while sum <= MAX_SUM
    answer = hit_or_stay?
    break if answer == 'stay'
    hit!(deck, current_status, :player_cards)
    display_cards(current_status[:player_cards])
  end
end

def hit_or_stay?()
  loop do
    prompt "Hit or Stay?"
    answer = gets.chomp.downcase
    break if %w(hit stay).include?(answer)
    prompt "Invalid input! Please enter only 'hit' or 'stay'"
  end
end

# def dealer_round(deck)
#
# end

deck = initialize_deck

current_status = { dealer_cards: [], player_cards: [], is_player_round: true}

initial_deal!(deck, current_status)

player_round(deck, current_status)

# dealer_round(deck, current_status)

# Pick cards for dealer and player

# "Show" cards of dealer and player
