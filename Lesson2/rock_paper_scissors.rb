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

def display_results(player, computer)
  if WINNING_CONDITIONS[player].include?(computer)
    prompt("You won!")

  elsif WINNING_CONDITIONS[computer].include?(player)
    prompt("Computer won! ")

  else
    prompt("It's a tie!")
  end
end

loop do
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

  computer_choice =  ITEMS_PARTICIPATING.sample()

  prompt("You chose: #{choice}; Computer chose: #{computer_choice}")

  display_results(choice, computer_choice)

  answer = ''
  prompt("Do you want to play again? ('y'/'n')")
  loop do
    answer = Kernel.gets().chomp().downcase()

    break if %w(y n).include?(answer)
    prompt("Invalid answer! Please answer only 'y' or 'n'")
  end

  break if answer == 'n'
end

prompt("Thanks for playing!")
