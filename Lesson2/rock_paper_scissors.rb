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
    :player
  elsif WINNING_CONDITIONS[computer].include?(player)
    :computer
  else
    :tie
  end
end

def display_results(winner)
  if winner == :player
    prompt("You won!")
  elsif winner == :computer
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
    loop do
      prompt("Choose one of the following:")
      prompt("[r]ock, [p]aper, [sc]issors, [sp]ock, [l]izard")

      choice = Kernel.gets().chomp().downcase()

      if ITEMS_PARTICIPATING.include?(choice) || VALID_CHOICES.key?(choice)
        choice = VALID_CHOICES[choice] if VALID_CHOICES.key?(choice)
        break
      end

      prompt("That's not a valid choice.")
    end

    computer_choice = ITEMS_PARTICIPATING.sample()

    prompt("You chose: #{choice};\tComputer chose: #{computer_choice}")

    who_won = decide_winner(choice, computer_choice)

    display_results(who_won)

    if who_won == :player
      player_score += 1
    elsif who_won == :computer
      computer_score += 1
    end

    prompt("Player Score: #{player_score};\tComputer Score: #{computer_score}")

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
