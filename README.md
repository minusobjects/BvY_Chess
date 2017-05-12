## BvY Chess

### Introduction

BvY Chess is a chess game built in Ruby. To play, navigate to the folder in the terminal and (assuming Ruby is installed) enter `ruby play.rb`. A prompt will ask if this game is vs. the AI or vs. another person.

In the game: move the cursor around the board with the arrow keys. Hit the Spacebar to select which piece to move, and then again to select which space to move it to. If the space you select is not a valid move for your piece, you will be re-prompted to select a piece.

The program ends when a player is in checkmate (or, just hit Ctrl-C to terminate).

### Features

**Move objects:** Taking some influence from my experiences with React.js/Redux - specifically, how the Redux architecture passes data down from an initial 'store' to various components - the potential moves (on a given turn) for the computer player are added to a hash, which is then passed to different methods which algorithmically filter the hash until it contains only the most desirable potential moves for that turn (i.e. a move that results in checkmate is prioritized over a move that results in check, a move that results in a captured bishop is prioritized over a move that results in a captured pawn, etc.). This means that it would be easy to, for example, have the AI choose moves completely at random, or have the AI select from a set of less-desirable moves - it's just a matter of setting restrictions on which moves will be included in the final instance of the hash.

**Single board:** Potential subsequent moves (necessary to determine moves for the computer player, and for determining whether or not a player is in checkmate) are calculated by modifying and then resetting a single instance of the board class. This ends up being less space-intensive than, for example, a solution which continually duplicates the board to calculate future moves.

**Object-oriented piece construction:** The various pieces were constructed using object-oriented programming patterns to maintain consistency. For example, all pieces inherit from a `Piece` class with variables for color, position and type, while the `Knight` and `King` classes inherit methods from a `Steppable` module to determine valid moves.

### Future

Going forward, I plan to build-out the computer player by using polytree data structures to store chains of potential moves, allowing the AI to choose its moves based on long-term outcome. Hi.
