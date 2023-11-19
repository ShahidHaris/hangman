puts 'hangman is initialized'

def select_word
  file = File.readlines('words.txt')

  guessed_word = file.select { |word| word.strip.size >= 5 and word.strip.size <= 12 }

  guessed_word.sample
end

def guessing_selection
  puts 'Try guessing a letter from the secret word'
  guess = gets.chomp

  until guess.size == 1
    puts 'You have to write only one letter'
    guess = gets.chomp.downcase
  end
  guess
end

empty = []
word = select_word
guess = guessing_selection
array = Array.new(word.size - 1) { '_' }

puts "The initial array is : #{array}"
puts "The initial word is : #{word}"

# Checks if the letter guessed is in the word selected, then print it out in the position, else add the word to empty
def give_a_clue(array, word, guess)
  word.chars.each_with_index do |letter, index|
    array[index] = letter if letter == guess
  end

  array.join(', ')
end

if word.include?(guess)
  give_a_clue(array, word, guess)
else
  empty << guess
end

puts "The final array is : #{array}"
puts "The empty array is : #{empty}"
