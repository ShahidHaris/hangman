require 'yaml'

class Hangman
  def initialize(file)
    initialize_saved_game if File.exist?('save_game.yaml')

    @data = File.readlines(file)
    @word = select_word
    @array = Array.new(@word.size - 1) { '_' }
    @attempts_left = 10
    @incorrect_guesses = []
  end

  def initialize_saved_game
    puts 'Do you want to load the saved game? (yes/no). Press enter if you have already done that'
    choice = gets.chomp.downcase
    return unless choice == 'yes'

    Hangman.load_game
  end

  def select_word
    guessed_word = @data.select { |word| word.strip.size >= 5 && word.strip.size <= 12 }
    guessed_word.sample
  end

  def guessing_selection
    puts 'Try guessing a letter from the secret word'
    guess = gets.chomp.downcase

    until guess.match?(/^[a-zA-Z]$/)
      puts 'Your input should be one letter and not a number'
      guess = gets.chomp.downcase
    end
    guess
  end

  def give_a_clue(guess)
    @word.chars.each_with_index do |letter, index|
      @array[index] = letter if letter == guess
    end

    @array.join(', ')
  end

  def save_game
    File.open('save_game.yaml', 'w') do |file|
      file.puts self.to_yaml
    end
    puts 'Game saved successfully!'
  end

  def self.load_game
    saved_game_data = YAML.load(File.read('save_game.yaml'))
    saved_game = Hangman.new('words.txt') # Create a new instance of Hangman
    saved_game.yaml_initialize(saved_game_data) # Initialize the instance with saved data
    puts 'Game loaded successfully!'
    saved_game.play # Call play method on the instance
  end

  def to_yaml
    YAML.dump(
      {
        'word' => @word,
        'array' => @array,
        'attempts_left' => @attempts_left,
        'incorrect_guesses' => @incorrect_guesses
      }
    )
  end

  def yaml_initialize(map)
    @word = map['word']
    @array = map['array'].nil? ? Array.new(@word.size - 1) { '_' } : map['array']
    @attempts_left = map['attempts_left']
    @incorrect_guesses = map['incorrect_guesses']
  end

  def game_stats
    puts "Current state: #{@array}"
    puts "Attempts left: #{@attempts_left}"
    puts "Incorrect guesses so far: #{@incorrect_guesses}"
  end

  def play_again
    @attempts_left -= 1
    @incorrect_guesses.join(', ')
    @array.include?('_') ? play : game_state
  end

  def keep_playing
    guess = guessing_selection

    if @word.include?(guess)
      give_a_clue(guess)
    else
      @incorrect_guesses << guess unless @incorrect_guesses.include?(guess)
    end
    play_again
  end

  def delete_saved_game
    File.delete('save_game.yaml') if File.exist?('save_game.yaml') && return
  end

  def game_state
    if !@array.include?('_')
      puts "Congratulations, You won! The word is: #{@word}"
      delete_saved_game
    elsif @attempts_left.positive?
      keep_playing
    else
      puts "Game over! The word is: #{@word}"
      delete_saved_game
    end
  end

  def play
    game_stats
    puts "Type 'save' to save the game and exit, or press enter to continue"

    input = gets.chomp.downcase

    if input == 'save'
      save_game
      return
    end

    game_state
  end
end

hangman = Hangman.new('words.txt')
hangman.play
