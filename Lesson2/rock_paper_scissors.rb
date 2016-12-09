VALID_CHOICES = %w(rock paper scissors)

def prompt(message)
  Kernel.puts("=> #{message}")
end

def win?(first, second)
  (first == 'rock' && second == 'scissors') ||
  (first == 'paper' && second == 'rock') ||
  (first == 'scissors' && second == 'paper')
end

def display_results(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("Computer won! ")
  else
    prompt("It's a tie!")
  end
end

loop do
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    choice = Kernel.gets().chomp()

    break if VALID_CHOICES.include?(choice.downcase())
    prompt("That's not a valid choice.")
  end

  computer_choice =  VALID_CHOICES.sample()

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
