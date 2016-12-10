LINE_BREAKS = 4

WINNING_SCORE = 5

ITEMS_PARTICIPATING = %w(rock paper scissors spock lizard)

VALID_CHOICES = {
  'r'   => 'rock',
  'p'   => 'paper',
  'sc'  => 'scissors',
  'sp'  => 'spock',
  'l'   => 'lizard'
}

WINNING_CONDITIONS = {
  'rock'     =>   %w(scissors lizard),
  'paper'    =>   %w(rock spock),
  'scissors' =>   %w(paper lizard),
  'spock'    =>   %w(rock scissors),
  'lizard'   =>   %w(spock paper)
}

def prompt(message)
  Kernel.puts("=> #{message}")
end

def decide_winner(player, computer)
  if WINNING_CONDITIONS[player].include?(computer)
    true

  elsif WINNING_CONDITIONS[computer].include?(player)
    false

  end
end

def display_results(player_won)
  if player_won
    prompt("You won!")

  elsif player_won == false
    prompt("Computer won!")

  else
    prompt("It's a tie!")
  end
end

def print_round_seperation
  Kernel.puts("\n" * LINE_BREAKS)
end

loop do
  computer_score = 0
  player_score = 0

  while (computer_score < WINNING_SCORE) && (player_score < WINNING_SCORE)
    choice = ''

    choice_instructions = <<-MSG
    Choose one of the following: #{ITEMS_PARTICIPATING.join(', ')}

    Make your choice by typing its first letter.
    If you have more than one item starting with the same letter, please use
    the first two letters
    MSG

    loop do
      prompt(choice_instructions)
      choice = VALID_CHOICES[Kernel.gets().chomp().downcase()]

      break if ITEMS_PARTICIPATING.include?(choice)
      prompt("That's not a valid choice.")
    end

    computer_choice = ITEMS_PARTICIPATING.sample()

    prompt("You chose: #{choice}; Computer chose: #{computer_choice}")

    player_won = decide_winner(choice, computer_choice)

    display_results(player_won)

    if player_won
      player_score += 1
    elsif player_won == false
      computer_score += 1
    end

    prompt("Computer Score: #{computer_score}; Player Score: #{player_score}")

    print_round_seperation()

  end

  if computer_score > player_score
    prompt("Computer won this game :(")
  else
    prompt("Good job! You won this game!")
  end

  answer = ''
  prompt("Do you want to play another one? ('y'/'n')")
  loop do
    answer = Kernel.gets().chomp().downcase()

    break if %w(y n).include?(answer)
    prompt("Invalid answer! Please answer only 'y' or 'n'")
  end

  break if answer == 'n'
end
prompt("Thanks for playing!")
