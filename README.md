# Hangman Game

This Hangman game is a text-based implementation in Ruby. It's part of the Full Stack Ruby on Rails curriculum of [The Odin Project](https://www.theodinproject.com). The game allows players to guess letters in order to reveal a hidden word. The player has a limited number of attempts, and the game can be saved and loaded for later play.

## Getting Started

1. Clone the repository or copy the code into a Ruby environment.
2. Make sure you have Ruby installed on your machine.
3. Run the script by executing `ruby lib/hangman.rb` in your terminal.

## How to Play

1. Upon starting the game, a random word is selected from the "words.txt" file. The player has to guess this word.
2. The player is prompted to guess a letter. Invalid inputs (numbers, multiple letters) are rejected until a valid letter is provided.
3. The game displays the current state of the word, the attempts left, and the incorrect guesses.
4. The player can type 'save' to save the game and exit or press enter to continue.
5. If the word is guessed correctly within the allowed attempts, the player wins. Otherwise, the game ends, and the correct word is revealed.

## Save and Load

- The game supports saving and loading functionality. If the player decides to save the game, it creates a "save_game.yaml" file.
- To load a saved game, run the script, and it will prompt you to load the saved game if available.

## Game Structure

- The `Hangman` class initializes the game, selects a random word, and sets up the necessary variables.
- The game state, including the word, guessed letters, attempts left, and incorrect guesses, is displayed to the player.
- The player can make guesses until the word is fully revealed or no attempts are left.
- The game supports saving and loading functionality using YAML serialization.

## Contributions

This project is part of [The Odin Project](https://www.theodinproject.com) curriculum. Contributions and improvements are welcome. Feel free to fork the repository, make changes, and submit a pull request.

## License

This Hangman game is open-source and available under the [MIT License](LICENSE). Feel free to use, modify, and distribute it as needed.