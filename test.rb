class Hangman
  def initialize(file)
    @data = File.readlines(file)
    @word = select_word
    @array = Array.new(@word.size - 1) { '_' }
    @attempts_left = 5
    @incorrect_guesses = []
  end

  def select_word
    guessed_word = @data.select { |word| word.strip.size >= 5 && word.strip.size <= 12 }
    guessed_word.sample
  end

  def guessing_selection
    puts 'Try guessing a letter from the secret word'
    guess = gets.chomp.downcase

    until guess.size == 1
      puts 'You have to write only one letter'
      guess = gets.chomp.downcase
    end
    guess
  end

  def give_a_clue(array, word, guess)
    word.chars.each_with_index do |letter, index|
      array[index] = letter if letter == guess
    end

    array.join(', ')
  end

  def play
    while @attempts_left.positive?
      @guess = guessing_selection

      if @word.include?(@guess)
        give_a_clue(@array, @word, @guess)
      else
        @attempts_left -= 1
        @incorrect_guesses << @guess
        puts "Incorrect guess! Attempts left: #{@attempts_left}"
        puts "Incorrect guesses so far: #{@incorrect_guesses.join(', ')}"
      end

      puts "Current state: #{@array}"
    end

    puts "Game over! The word was: #{@word}"
  end
end

hangman = Hangman.new('words.txt')
hangman.play
