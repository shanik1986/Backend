#Givern an array of integers - numbers

Create a new empty array named few_numbers
Create variable choose = true
Iterate through numbers
  For each value of numbers:
  If choose = false
    next
  else
    Add the current value of numbers to the few_numbers array
  Set choose to !choose

START
SET few_numbers = []
SET choose = true
SET numbers_iterator = 1
SET few_iterator = 1

WHILE numbers_iterator < length of numbers
  IF choose == false
    go to the next iteration
  ELSE
    SET the value of few_numbers at space "few_iterator" to the current value of numbers at space "iterator"
  SET choose = !choose
  SET numbers_iterator = numbers_iterator + 1
  SET few_iterator = few_iterator + 1

PRINT few_numbers

END
