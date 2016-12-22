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
SUITS = { 'H' => 'Hearts', 'C' => 'Clubs', 'D' => 'Diamonds', 'S' => 'Spades' }

# VALUES = { 'Ace' => 11 }
# SUITS = { 'H' => 'Hearts', 'C' => 'Clubs', 'D' => 'Diamonds', 'S' => 'Spades',
#           'R' => 'Random', 'R2' => 'Random2', 'R3' => 'Random3',
#           'R4' => 'Random4'
#         }

MAX_SUM = 21
DEALER_MAX = 17

def prompt(msg)
  puts "=> #{msg}"
end

def initialize_deck
  deck = []
  VALUES.each_key do |card|
    SUITS.each_key do |suit|
      deck << [card, suit]
    end
  end
  deck
end

def get_all_firsts(nested_array)
  firsts = []
  nested_array.each { |item| firsts << item.first }
  firsts
end

def display_cards(identity, cards)
  prompt "#{identity} has: #{join_and(get_all_firsts(cards))}"
end

def join_and(array, delimeter = ', ', last_item_connection = 'and')
  if array.size > 1
    series = array[0..(array.size - 2)].join(delimeter)
    series += " #{last_item_connection} #{array.last}"
  else
    series = array[0]
  end
  series
end

def hit!(deck, status, number = 1)
  number.times do
    status[:cards] << deck.delete(deck.sample)
    status[:unadjusted_aces] += 1 if status[:cards].last.first == 'Ace'
  end
end

def player_round(deck, player_status)
  initialize_round!(player_status)

  while player_status[:sum] < MAX_SUM
    answer = hit_or_stay?
    break if answer == 'stay'
    hit!(deck, player_status)
    update_status!(player_status)

    display_cards('Player', player_status[:cards])
  end
end


def dealer_round(deck, dealer_status)
  initialize_round!(dealer_status)
  binding.pry

  while dealer_status[:sum] < 17
    hit!(deck, dealer_status)
    update_status!(dealer_status)
    display_cards('Dealer', dealer_status[:cards])
  end
  prompt "Dealer Busts" if dealer_status[:sum] > 21
end

def initialize_round!(status)
  status[:sum] = calculate_sum(status[:cards])
  adjust_for_aces!(status) if status[:sum] > 21
end

def update_status!(status)
  last_card = status[:cards].last
  status[:sum] += VALUES[last_card.first]
  binding.pry
  if status[:unadjusted_aces] > 0 && status[:sum] > 21
    adjust_for_aces!(status)
  end
end

def adjust_for_aces!(status)
  while status[:sum] > 21 && status[:unadjusted_aces] > 0
    status[:sum] -= 10
    status[:unadjusted_aces] -= 1
  end
end

def calculate_sum(cards)
  sum = 0

  all_values = VALUES.values_at(*get_all_firsts(cards))
  all_values.each {|value| sum += value}
  sum
end

def hit_or_stay?
  answer = ''
  loop do
    prompt "Hit or Stay?"
    answer = gets.chomp.downcase
    break if %w(hit stay).include?(answer)
    prompt "Invalid input! Please enter only 'hit' or 'stay'"
  end
  answer
end

deck = initialize_deck
dealer_status = { cards: [], sum: 0, unadjusted_aces: 0 }
player_status = { cards: [], sum: 0, unadjusted_aces: 0 }

hit!(deck, dealer_status, 2) #Deal the dealer's first two cards
hit!(deck, player_status, 2) #Deal the player's first two cards

prompt "Dealer has: #{dealer_status[:cards].first.first} and an unknown card"
display_cards('Player', player_status[:cards])

player_round(deck, player_status)

dealer_round(deck, dealer_status)

# Pick cards for dealer and player

# "Show" cards of dealer and player
