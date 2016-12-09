require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

puts MESSAGES.inspect
