require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

puts MESSAGES['hi_with_name']
